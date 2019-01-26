#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include <math.h>

#define MAX_BUFF 1024

typedef struct
{
	int	year ;
	double Pru ;
	double ZRP ;
	double cash ;
	double inflation ;
	double AnnuityIncrease ;
	double investmentReturn ;
	double cashReturn ;
	double PruIncome ;
	double ZRPIncome ;
	double cashIncome ;
	double rentIncome ;
	double stateIncome ;
	double FerrantiIncome ;
	double SimonIncome ;
	double F1 ;
	double F2 ;
	double F3 ;
	double F4 ;
	double F5 ;
	double F6 ;
	double S1 ;
	double S2 ;
	double Spend ;
	double TaxAllowance ;
	double total ;
	double inheritance ;
	double income ;
	double tax ;
} Year ;

static Year	years[100] ;
static int InheritYear = 2024 ;
static int PruYear = 2024 ;
static int Pru25 = 0 ;
static int ZRPYear = 2019 ;
static int ZRP25 = 1 ;
static int FerrantiYear = 2019 ;
static int SimonYear = 2019 ;
static double InflationMean = 0.0 ;
static double InflationSD = 0.0 ;
static double InvestMean = 0.0 ;
static double InvestSD = 0.0 ;
static double CashMean = 0.0 ;
static double CashSD = 0.0 ;
static double SpendDecrease = 0.0 ;

calculateAnnuityInflation(Year *year)
{
	year->AnnuityIncrease = year->inflation - 1.0 ;
	if (year->AnnuityIncrease < 2.5)
		year->AnnuityIncrease = 2.5 ;
	if (year->AnnuityIncrease > 5.0)
		year->AnnuityIncrease = 5.0 ;
}

calculateNewIncomes(Year *year, Year *lastyear)
{

	year->FerrantiIncome = (1.0 + (lastyear->AnnuityIncrease * 0.01)) * lastyear->FerrantiIncome ;
	year->SimonIncome = (1.0 + (lastyear->AnnuityIncrease * 0.01)) * lastyear->SimonIncome ;
	year->stateIncome = (1.0 + (lastyear->inflation * 0.01)) * lastyear->stateIncome ;
	year->rentIncome = (1.0 + (lastyear->inflation * 0.01)) * lastyear->rentIncome ;
	year->TaxAllowance = (1.0 + (lastyear->inflation * 0.01)) * lastyear->TaxAllowance ;
	year->Spend = lastyear->Spend * ((100.0 - SpendDecrease)/100.0) ;
	year->Spend = (1.0 + (lastyear->inflation * 0.01)) * year->Spend ;
	year->inheritance = (1.0 + (lastyear->inflation * 0.01)) * lastyear->inheritance ;
	year->S1 = 1.07 * lastyear->S1 ;
	year->S2 = (1.0 + (lastyear->inflation * 0.01)) * lastyear->S2 ;
	year->F1 = 1.075 * lastyear->F1 ;
	year->F2 = 1.075 * lastyear->F2 ;
	year->F3 = 1.075 * lastyear->F3 ;
	year->F4 = (1.0 + (lastyear->inflation * 0.01)) * lastyear->F4 ;
	year->F5 = (1.0 + (lastyear->inflation * 0.01)) * lastyear->F5 ;
	year->F6 = 1.075 * lastyear->F6 ;

	if (lastyear->year != InheritYear)
		lastyear->inheritance = 0 ;
	if (lastyear->year < InheritYear)
		lastyear->rentIncome = 0 ;
	if (lastyear->year <2031)
		lastyear->stateIncome = 0 ;
}

calculateNewTotals (Year *year, Year *lastyear)
{
	if ((lastyear->FerrantiIncome < 1.0) && (lastyear->year == FerrantiYear))
	{
		int yearsEarly = 2029 - lastyear->year ;
		double reductionFactor = (100 - (yearsEarly * 1.5)) * 0.01 ;
		lastyear->FerrantiIncome = reductionFactor * (lastyear->F1 + lastyear->F2 + lastyear->F3 + lastyear->F4 + lastyear->F5 + lastyear->F6) ;
	}
	if ((lastyear->SimonIncome < 1.0) && (lastyear->year == SimonYear))
	{
		int yearsEarly = 2029 - lastyear->year ;
		double reductionFactor = (100 - (yearsEarly * 1.5)) * 0.01 ;
		lastyear->SimonIncome = reductionFactor * (lastyear->S1 + lastyear->S2) ;
	}

	lastyear->income = lastyear->FerrantiIncome + lastyear->SimonIncome + lastyear->cashIncome 
						+ lastyear->ZRPIncome + lastyear->PruIncome;
	if (year->year > InheritYear)
		lastyear->income += lastyear->rentIncome ;

	if (year->year > 2031)
		lastyear->income += lastyear->stateIncome ;

	double taxable = lastyear->income - lastyear->TaxAllowance ;

	// note - assume only half the cashIncome is taxable (ISAs, allowances etc)
	taxable -= (lastyear->cashIncome * 0.5) ;

	// and only 75% of ZRP and Pru taxable if we haven't taken 25% lump sum
	if (!Pru25)
		taxable -= (lastyear->PruIncome * 0.25) ;
	if (!ZRP25)
		taxable -= (lastyear->ZRPIncome * 0.25) ;

	lastyear->tax = 0 ;
	if (taxable > 0)
		lastyear->tax = taxable * 0.2 ;

	// note - this may well be negative
	double cashSpend = lastyear->Spend + lastyear->tax - lastyear->income ;

	year->cash = lastyear->cash - cashSpend ;
	if (year->year == InheritYear + 1)
		year->cash += lastyear->inheritance ;
	year->cashIncome = (year->cashReturn * 0.01) * year->cash;
	year->ZRP = ((1.0 + (lastyear->investmentReturn * 0.01)) * lastyear->ZRP) - lastyear->ZRPIncome;
	year->Pru = ((1.0 + (lastyear->investmentReturn * 0.01)) * lastyear->Pru) - lastyear->PruIncome;
	year->total = year->ZRP + year->Pru + year->cash ;

	if (year->year == ZRPYear)
	{
		if (ZRP25)
		{
			double cashTake = year->ZRP * 0.25 ;
			year->ZRP -= cashTake ;
			year->cash += cashTake ;
		}
	}
	if (year->year == PruYear)
	{
		if (Pru25)
		{
			double cashTake = year->Pru * 0.25 ;
			year->Pru -= cashTake ;
			year->cash += cashTake ;
		}
	}
}

int calculateIncome (Year *year)
{
	// note - assume only half the cashIncome is taxable (ISAs, allowances etc)
	double income = year->FerrantiIncome + year->SimonIncome + (year->cashIncome * 0.5) ;
	if (year->year >= InheritYear)
		income += year->rentIncome ;
	if (year->year > 2031)
		income += year->stateIncome ;

	double taxable = income - year->TaxAllowance ;

	double tax = 0 ;
	if (taxable > 0)
		tax = taxable * 0.2 ;

	// how much extra do we still need?
	double required = year->Spend + tax - income ;

	// how much can we take tax free?
	double taxFree = year->TaxAllowance - income ;
	if (taxFree < 0.0)
		taxFree = 0.0;

	// take the tax free amount from ZRP and pru
	if (year->year >= ZRPYear && year->year < PruYear)
	{
		year->ZRPIncome = taxFree ;
	}
	else if (year->year >= PruYear && year->year < ZRPYear)
	{
		year->PruIncome = taxFree ;
	}
	else if (year->year >= PruYear && year->year >= ZRPYear)
	{
		year->ZRPIncome = taxFree / 2.0 ;
		year->PruIncome = taxFree / 2.0 ;
	}

	// how much do we still need?
	required -= taxFree ;
	if (required < 0)
		required = 0 ;

	// take the extra required (plus 25% for tax) proportionate to
	// what we have left in each pot

	if (required > 0)
	{
		required *= 1.25;
		if (year->year >= ZRPYear && year->year < PruYear)
		{
			year->ZRPIncome += (year->ZRP / (year->ZRP + year->cash)) * required ;
		}
		else if (year->year >= PruYear && year->year < ZRPYear)
		{
			year->PruIncome += (year->Pru / (year->Pru + year->cash)) * required ;
		}
		else if (year->year >= PruYear && year->year >= ZRPYear)
		{
			year->ZRPIncome += (year->ZRP / year->total) * required ;
			year->PruIncome += (year->Pru / year->total) * required ;
		}
	}

	return 0 ;
}

double StandardDeviationsFromMean(double SD)
{
	int sdkey = random()%1000 ;
	int interval = random()%50 ;
	double adjust = interval / 100.0 ;
	double amount = 0.0 ;

	if (sdkey <= 6)
		amount = -2.5 ;
	else if (sdkey <= 23)
		amount = -2.0 ;
	else if (sdkey <= 67)
		amount = -1.5 ;
	else if (sdkey <= 159)
		amount = -1.0 ;
	else if (sdkey <= 309)
		amount = -0.5 ;
	else if (sdkey <= 500)
		amount = 0.0 ;
	else if (sdkey <= 691)
		amount = 0.5 ;
	else if (sdkey <= 841)
		amount = 1.0 ;
	else if (sdkey <= 933)
		amount = 1.5 ;
	else if (sdkey <= 977)
		amount = 2.0 ;
	else if (sdkey <= 994)
		amount = 2.5 ;
	else
		amount = 3.0 ;

	return ((amount - adjust) * SD) ;
}

int setupReturns(Year *year) 
{
	//int InflationDiff = (InflationMax - InflationMin) * 10 ;
	//int inflation = (InflationDiff > 0) ? random()%InflationDiff : 0;
	//year->inflation = (inflation / 10.0) + InflationMin ;
	year->inflation = InflationMean + StandardDeviationsFromMean(InflationSD) ;

	//int InvestDiff = (InvestMax - InvestMin) * 10 ;
	//int invest = (InvestDiff > 0) ? random()%InvestDiff : 0;
	//year->investmentReturn = (invest / 10.0) + InvestMin ;
	year->investmentReturn = InvestMean + StandardDeviationsFromMean(InvestSD) ;

	//int CashDiff = (CashMax - CashMin) * 10 ;
	//int cash = (CashDiff > 0) ? random()%CashDiff : 0;
	//year->cashReturn = (cash / 10.0) + CashMin ;
	year->cashReturn = CashMean + StandardDeviationsFromMean(CashSD) ;
}

int processYear (Year *year, Year *lastyear)
{
	int finished = 0 ;
	
	setupReturns(year);
	calculateAnnuityInflation(year);
	calculateNewTotals(year, lastyear);
	calculateNewIncomes(year, lastyear);
	calculateIncome(year);

	return 0 ;
}

setupFerranti (Year *year)
{	
	FILE *stream = fopen ("FerrantiData", "r") ;
	int i=0;

	char	buffer[MAX_BUFF+1] = "" ;
	for (i=0;i<10;i++)
	{
		if (fgets (buffer, MAX_BUFF, stream))
		{
			char *rest = NULL ;
			char *ptr = NULL;
	
			ptr = (char *) strtok_r (buffer, ":", &rest) ;
			int theyear = atoi(ptr) ;
	
			if (theyear == year->year)
			{
				ptr = (char *) strtok_r (NULL, ":", &rest) ;
				year->F1 = atof (ptr);
				ptr = (char *) strtok_r (NULL, ":", &rest) ;
				year->F2 = atof (ptr);
				ptr = (char *) strtok_r (NULL, ":", &rest) ;
				year->F3 = atof (ptr);
				ptr = (char *) strtok_r (NULL, ":", &rest) ;
				year->F4 = atof (ptr);
				ptr = (char *) strtok_r (NULL, ":", &rest) ;
				year->F5 = atof (ptr);
				ptr = (char *) strtok_r (NULL, ":", &rest) ;
				year->F6 = atof (ptr);
			}
		}
	}
	fclose (stream) ;
}

setupSimon (Year *year)
{	
	FILE *stream = fopen ("SimonData", "r") ;
	int	i=0;

	char	buffer[MAX_BUFF+1] = "" ;
	for (i=0;i<10;i++)
	{
		if (fgets (buffer, MAX_BUFF, stream))
		{
			char *rest = NULL ;
			char	*ptr = NULL;
	
			ptr = (char *) strtok_r (buffer, ":", &rest) ;
			int theyear = atoi(ptr) ;
	
			if (theyear == year->year)
			{
				ptr = (char *) strtok_r (NULL, ":", &rest) ;
				year->S1 = atof (ptr);
				ptr = (char *) strtok_r (NULL, ":", &rest) ;
				year->S2 = atof (ptr);
			}
		}
	}
	fclose (stream) ;
}

main(argc, argv)
int 	argc ;
char	**argv ;
{
	int nextYear = 0 ;
	int finished = 0 ;
	int html = 1 ;
	int loop = 0 ;
	Year *firstyear = NULL ;

	if (argc != 27)
	{
		printf ("Usage: cash <random seed> <rent> <inherit> <inheritYear> <spend> <ZRPYear> <ZRP25> <PruYear> <Pru25> <FerrantiYear> <SimonYear>\n");
		printf ("                                   <InflationMean> <InflationSD> <InvestMean> <InvestSD> <CashMean> <CashSD> <SpendDecrease>\n");
		printf ("                                   <FirstYear> <ZRP> <Pru> <cash> <FerrantiAmount> <SimonAmount> <stateAmount> <taxAllowance>\n");
		exit (0) ;
	}
    // init random seed

	int seed = atoi (argv[1]) ;
    srandom (seed) ;

	// store the inheritance year

	InheritYear = atoi (argv[4]) ;

#if 0
	/* open the file containing the rates */

	if (argc !=2 && argc !=3)
	{
		printf ("Usage: cash <filename>\n");
		printf ("   or: cash -html <filename>\n");
		exit (0) ;
	}

	if (!strcmp (argv[1], "-html"))
	{
		stream = fopen (argv[2], "r") ;
		html = 1 ;
	}
	else	
		stream = fopen (argv[1], "r") ;
#endif

	// read in starting amounts

	firstyear = &years[0];
	firstyear->year = atoi (argv[19]);
	firstyear->ZRP = atof (argv[20]) * 1000;
	firstyear->Pru = atof (argv[21]) * 1000;
	firstyear->cash = atof (argv[22]) * 1000;
	firstyear->rentIncome = atof(argv[2]) ;
	firstyear->inheritance = atof(argv[3]) * 1000;
	firstyear->Spend = atof(argv[5]) ;
	ZRPYear = atoi (argv[6]) ;
	ZRP25 = atoi (argv[7]) ;
	PruYear = atoi (argv[8]) ;
	Pru25 = atoi (argv[9]) ;
	FerrantiYear = atoi (argv[10]) ;
	SimonYear = atoi (argv[11]) ;
	InflationMean = atof (argv[12]) ;
	InflationSD = atof (argv[13]) ;
	InvestMean = atof (argv[14]) ;
	InvestSD = atof (argv[15]) ;
	CashMean = atof (argv[16]) ;
	CashSD = atof (argv[17]) ;
	SpendDecrease = atof (argv[18]) ;
	firstyear->FerrantiIncome = atof (argv[23]) ;
	setupFerranti (firstyear) ;
	firstyear->SimonIncome = atof (argv[24]) ;
	setupSimon (firstyear) ;
	firstyear->stateIncome = atof (argv[25]) ;
	firstyear->TaxAllowance = atof (argv[26]) ;
	

	setupReturns (firstyear) ;

	if (firstyear->year == ZRPYear)
	{
		if (ZRP25)
		{
			double cashTake = firstyear->ZRP * 0.25 ;
			firstyear->ZRP -= cashTake ;
			firstyear->cash += cashTake ;
		}
	}
	if (firstyear->year == PruYear)
	{
		if (Pru25)
		{
			double cashTake = firstyear->Pru * 0.25 ;
			firstyear->Pru -= cashTake ;
			firstyear->cash += cashTake ;
		}
	}
	firstyear->total = firstyear->ZRP + firstyear->Pru + firstyear->cash ;
	firstyear->cashIncome = (firstyear->cashReturn * 0.01) * firstyear->cash;

	if ((firstyear->FerrantiIncome < 1.0) && (firstyear->year == FerrantiYear))
	{
		int yearsEarly = 2029 - firstyear->year ;
		double reductionFactor = (100 - (yearsEarly * 1.5)) * 0.01 ;
		firstyear->FerrantiIncome = reductionFactor * (firstyear->F1 + firstyear->F2 + firstyear->F3 + firstyear->F4 + firstyear->F5 + firstyear->F6) ;
	}
	if ((firstyear->SimonIncome < 1.0) && (firstyear->year == SimonYear))
	{
		int yearsEarly = 2029 - firstyear->year ;
		double reductionFactor = (100 - (yearsEarly * 1.5)) * 0.01 ;
		firstyear->SimonIncome = reductionFactor * (firstyear->S1 + firstyear->S2) ;
	}

	calculateAnnuityInflation(firstyear);
	calculateIncome(firstyear);

	// now process every year

	for (nextYear = 1; nextYear<=45; nextYear++)
	{
		years[nextYear].year = nextYear + firstyear->year;
		processYear(&years[nextYear], &years[nextYear-1]);
	}

	/* print out the results */

	if (!html)
	{
		for (loop=0;loop<nextYear-1;loop++)
		{
			printf ("%d, ZRP %d, Pru %d, Cash %d Total %d Tax %d Spend %d\n", years[loop].year, (int) years[loop].ZRP,
														(int) years[loop].Pru, (int) years[loop].cash, (int) years[loop].total,
															(int) years[loop].tax, (int) years[loop].Spend) ;
		}
	}
	else
	{
		printf ("<center><TABLE COLS=10\n border=3>") ;
		printf ("<TR>\n") ;
		printf ("<TD><center>year<center>\n") ;
		printf ("<TD><center>ZRPTotal<center>\n") ;
		printf ("<TD><center>PruTotal<center>\n") ;
		printf ("<TD><center>investReturn<center>\n") ;
		printf ("<TD><center>Cash<center>\n") ;
		printf ("<TD><center>CashReturn<center>\n") ;
		printf ("<TD><center>inflation<center>\n") ;
		printf ("<TD><center>ZRPIncome<center>\n") ;
		printf ("<TD><center>PruIncome<center>\n") ;
		printf ("<TD><center>cashIncome<center>\n") ;
		printf ("<TD><center>rentIncome<center>\n") ;
		printf ("<TD><center>stateIncome<center>\n") ;
		printf ("<TD><center>FerrantiIncome<center>\n") ;
		printf ("<TD><center>SimonIncome<center>\n") ;
		printf ("<TD><center>Spend<center>\n") ;
		printf ("<TD><center>TaxAllowance<center>\n") ;
		printf ("<TD><center>Tax<center>\n") ;
		printf ("<TD><center>total<center>\n") ;
		printf ("<TD><center>inheritance<center>\n") ;
		printf ("<TD><center>income<center>\n") ;
		printf ("<TD><center>Ratio<center>\n") ;
		printf ("<TR>\n") ;
		for (loop=0;loop<nextYear-1;loop++)
		{
			printf ("<TR>\n") ;
			printf ("<TD><center>%d<center>\n", years[loop].year) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].ZRP) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].Pru) ;
			printf ("<TD><center>%.2f<center>\n", years[loop].investmentReturn) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].cash) ;
			printf ("<TD><center>%.2f<center>\n", years[loop].cashReturn) ;
			printf ("<TD><center>%.2f<center>\n", years[loop].inflation) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].ZRPIncome) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].PruIncome) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].cashIncome) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].rentIncome) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].stateIncome) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].FerrantiIncome) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].SimonIncome) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].Spend) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].TaxAllowance) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].tax) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].total) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].inheritance) ;
			printf ("<TD><center>%d<center>\n", (int)years[loop].income) ;
			printf ("<TD><center>%.1f<center>\n", (years[loop].total / years[loop].Spend)) ;
			printf ("</TR>\n") ;
		}
		printf ("</TABLE>\n") ;
	}

	/* close the input stream */

	//fclose (stream) ;
}
