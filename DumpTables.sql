-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bback`
--

USE betfair;

DROP TABLE IF EXISTS `bback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bback` (
  `BACK` float DEFAULT NULL,
  `SCORE` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bback`
--

LOCK TABLES `bback` WRITE;
/*!40000 ALTER TABLE `bback` DISABLE KEYS */;
INSERT INTO `bback` VALUES (1.36,0),(1.39,0.00584795),(1.53,0.0116959),(1.61,0.0175439),(1.71,0.0233918),(1.82,0.0292398),(1.86,0.0350877),(2.02,0.0409357),(2.08,0.0467836),(2.24,0.0526316),(2.26,0.0584795),(2.3,0.0643275),(2.46,0.0701754),(2.48,0.0760234),(2.68,0.0818713),(2.7,0.0877193),(2.72,0.0935673),(2.78,0.0994152),(2.8,0.105263),(2.82,0.111111),(2.84,0.116959),(2.92,0.122807),(2.94,0.128655),(3.15,0.134503),(3.2,0.140351),(3.3,0.146199),(3.35,0.152047),(3.55,0.157895),(3.6,0.163743),(3.65,0.169591),(3.7,0.175439),(3.75,0.181287),(3.8,0.187135),(3.85,0.192982),(3.9,0.19883),(3.95,0.204678),(4,0.210526),(4.1,0.216374),(4.2,0.222222),(4.3,0.22807),(4.4,0.233918),(4.5,0.239766),(4.6,0.245614),(4.7,0.251462),(4.8,0.25731),(4.9,0.263158),(5,0.269006),(5.1,0.274854),(5.2,0.280702),(5.3,0.28655),(5.4,0.292398),(5.5,0.298246),(5.6,0.304094),(5.7,0.309942),(5.8,0.315789),(5.9,0.321637),(6,0.327485),(6.2,0.333333),(6.4,0.339181),(6.6,0.345029),(6.8,0.350877),(7,0.356725),(7.2,0.362573),(7.4,0.368421),(7.6,0.374269),(7.8,0.380117),(8,0.385965),(8.2,0.391813),(8.4,0.397661),(8.6,0.403509),(8.8,0.409357),(9,0.415205),(9.2,0.421053),(9.4,0.426901),(9.6,0.432749),(9.8,0.438596),(10,0.444444),(10.5,0.450292),(11,0.45614),(11.5,0.461988),(12,0.467836),(12.5,0.473684),(13,0.479532),(13.5,0.48538),(14,0.491228),(14.5,0.497076),(15,0.502924),(15.5,0.508772),(16,0.51462),(16.5,0.520468),(17,0.526316),(17.5,0.532164),(18,0.538012),(18.5,0.54386),(19,0.549708),(19.5,0.555556),(20,0.561404),(21,0.567251),(22,0.573099),(23,0.578947),(24,0.584795),(25,0.590643),(26,0.596491),(27,0.602339),(28,0.608187),(29,0.614035),(30,0.619883),(32,0.625731),(34,0.631579),(36,0.637427),(38,0.643275),(40,0.649123),(42,0.654971),(44,0.660819),(46,0.666667),(48,0.672515),(50,0.678363),(55,0.684211),(60,0.690058),(65,0.695906),(70,0.701754),(75,0.707602),(80,0.71345),(85,0.719298),(90,0.725146),(95,0.730994),(100,0.736842),(110,0.74269),(120,0.748538),(130,0.754386),(140,0.760234),(150,0.766082),(160,0.77193),(170,0.777778),(180,0.783626),(190,0.789474),(200,0.795322),(210,0.80117),(220,0.807018),(230,0.812865),(250,0.818713),(260,0.824561),(270,0.830409),(290,0.836257),(310,0.842105),(320,0.847953),(350,0.853801),(360,0.859649),(370,0.865497),(380,0.871345),(400,0.877193),(430,0.883041),(440,0.888889),(450,0.894737),(460,0.900585),(480,0.906433),(490,0.912281),(500,0.918129),(550,0.923977),(600,0.929825),(620,0.935673),(630,0.94152),(640,0.947368),(690,0.953216),(740,0.959064),(800,0.964912),(810,0.97076),(850,0.976608),(860,0.982456),(890,0.988304),(900,0.994152);
/*!40000 ALTER TABLE `bback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fforecast`
--

DROP TABLE IF EXISTS `fforecast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fforecast` (
  `FORECAST` float DEFAULT NULL,
  `SCORE` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fforecast`
--

LOCK TABLES `fforecast` WRITE;
/*!40000 ALTER TABLE `fforecast` DISABLE KEYS */;
INSERT INTO `fforecast` VALUES (1.55,0),(1.8,0.00275482),(2.02,0.00550964),(2.1,0.00826446),(2.25,0.0110193),(2.28,0.0137741),(2.44,0.0165289),(2.57,0.0192837),(2.62,0.0220386),(2.75,0.0247934),(2.86,0.0275482),(2.88,0.030303),(3.07,0.0330578),(3.17,0.0358127),(3.18,0.0385675),(3.19,0.0413223),(3.21,0.0440771),(3.25,0.046832),(3.41,0.0495868),(3.5,0.0523416),(3.65,0.0550964),(3.68,0.0578512),(3.73,0.0606061),(3.75,0.0633609),(3.83,0.0661157),(3.88,0.0688705),(3.97,0.0716253),(3.98,0.0743802),(4,0.077135),(4.05,0.0798898),(4.09,0.0826446),(4.15,0.0853994),(4.22,0.0881543),(4.23,0.0909091),(4.33,0.0936639),(4.45,0.0964187),(4.47,0.0991736),(4.48,0.101928),(4.5,0.104683),(4.55,0.107438),(4.58,0.110193),(4.63,0.112948),(4.8,0.115702),(4.83,0.118457),(4.85,0.121212),(4.9,0.123967),(4.97,0.126722),(5,0.129477),(5.04,0.132231),(5.08,0.134986),(5.09,0.137741),(5.25,0.140496),(5.28,0.143251),(5.43,0.146006),(5.45,0.14876),(5.48,0.151515),(5.5,0.15427),(5.53,0.157025),(5.63,0.15978),(5.65,0.162534),(5.73,0.165289),(5.83,0.168044),(5.84,0.170799),(5.88,0.173554),(5.9,0.176309),(5.91,0.179063),(5.96,0.181818),(5.98,0.184573),(6,0.187328),(6.04,0.190083),(6.09,0.192837),(6.15,0.195592),(6.23,0.198347),(6.36,0.201102),(6.38,0.203857),(6.46,0.206612),(6.5,0.209366),(6.53,0.212121),(6.59,0.214876),(6.68,0.217631),(6.72,0.220386),(6.8,0.22314),(6.81,0.225895),(6.87,0.22865),(6.92,0.231405),(6.94,0.23416),(6.96,0.236915),(7,0.239669),(7.03,0.242424),(7.17,0.245179),(7.19,0.247934),(7.2,0.250689),(7.23,0.253444),(7.3,0.256198),(7.32,0.258953),(7.41,0.261708),(7.46,0.264463),(7.5,0.267218),(7.53,0.269972),(7.58,0.272727),(7.64,0.275482),(7.67,0.278237),(7.68,0.280992),(7.74,0.283747),(7.75,0.286501),(7.79,0.289256),(7.81,0.292011),(7.89,0.294766),(7.94,0.297521),(7.95,0.300275),(8,0.30303),(8.18,0.305785),(8.36,0.30854),(8.4,0.311295),(8.43,0.31405),(8.44,0.316804),(8.45,0.319559),(8.47,0.322314),(8.49,0.325069),(8.5,0.327824),(8.52,0.330579),(8.79,0.333333),(8.8,0.336088),(8.95,0.338843),(8.96,0.341598),(8.99,0.344353),(9,0.347107),(9.13,0.349862),(9.15,0.352617),(9.3,0.355372),(9.33,0.358127),(9.35,0.360882),(9.38,0.363636),(9.41,0.366391),(9.5,0.369146),(9.53,0.371901),(9.66,0.374656),(9.81,0.37741),(9.88,0.380165),(9.89,0.38292),(9.94,0.385675),(9.96,0.38843),(10,0.391185),(10.08,0.393939),(10.11,0.396694),(10.15,0.399449),(10.2,0.402204),(10.31,0.404959),(10.35,0.407714),(10.4,0.410468),(10.9,0.413223),(10.93,0.415978),(10.94,0.418733),(10.96,0.421488),(11,0.424242),(11.03,0.426997),(11.05,0.429752),(11.25,0.432507),(11.27,0.435262),(11.41,0.438017),(11.45,0.440771),(11.66,0.443526),(11.68,0.446281),(11.77,0.449036),(11.8,0.451791),(11.82,0.454545),(11.93,0.4573),(12,0.460055),(12.19,0.46281),(12.23,0.465565),(12.29,0.46832),(12.4,0.471074),(12.41,0.473829),(12.6,0.476584),(12.69,0.479339),(12.75,0.482094),(12.9,0.484848),(12.92,0.487603),(12.93,0.490358),(12.95,0.493113),(13,0.495868),(13.07,0.498623),(13.18,0.501377),(13.37,0.504132),(13.45,0.506887),(13.48,0.509642),(13.63,0.512397),(13.64,0.515152),(13.75,0.517906),(13.93,0.520661),(14.06,0.523416),(14.32,0.526171),(14.43,0.528926),(14.6,0.53168),(14.71,0.534435),(14.78,0.53719),(14.82,0.539945),(14.91,0.5427),(15,0.545455),(15.2,0.548209),(15.28,0.550964),(15.3,0.553719),(15.79,0.556474),(15.94,0.559229),(15.96,0.561983),(16,0.564738),(16.14,0.567493),(16.19,0.570248),(16.23,0.573003),(16.28,0.575758),(16.29,0.578512),(16.47,0.581267),(16.6,0.584022),(16.69,0.586777),(16.78,0.589532),(16.87,0.592287),(16.9,0.595041),(16.93,0.597796),(17,0.600551),(17.26,0.603306),(17.64,0.606061),(17.68,0.608815),(17.81,0.61157),(17.88,0.614325),(18.3,0.61708),(18.45,0.619835),(18.63,0.62259),(18.77,0.625344),(18.89,0.628099),(18.92,0.630854),(19,0.633609),(19.08,0.636364),(19.25,0.639118),(19.38,0.641873),(19.52,0.644628),(19.78,0.647383),(19.93,0.650138),(19.98,0.652893),(20.12,0.655647),(20.17,0.658402),(20.41,0.661157),(20.5,0.663912),(20.59,0.666667),(20.63,0.669421),(20.87,0.672176),(20.88,0.674931),(20.92,0.677686),(21,0.680441),(21.36,0.683196),(21.83,0.68595),(22.49,0.688705),(22.82,0.69146),(22.86,0.694215),(22.91,0.69697),(23,0.699724),(23.4,0.702479),(23.61,0.705234),(23.64,0.707989),(24,0.710744),(24.38,0.713499),(24.66,0.716253),(24.8,0.719008),(24.82,0.721763),(24.97,0.724518),(25.8,0.727273),(25.84,0.730028),(25.9,0.732782),(26,0.735537),(26.1,0.738292),(26.13,0.741047),(26.34,0.743802),(26.58,0.746556),(26.93,0.749311),(27.19,0.752066),(27.68,0.754821),(28.31,0.757576),(28.55,0.760331),(28.65,0.763085),(28.77,0.76584),(28.83,0.768595),(29,0.77135),(29.86,0.774105),(30.49,0.77686),(30.56,0.779614),(30.6,0.782369),(30.87,0.785124),(30.89,0.787879),(31.17,0.790634),(31.99,0.793388),(33.35,0.796143),(33.73,0.798898),(33.8,0.801653),(34,0.804408),(34.79,0.807163),(34.87,0.809917),(36.77,0.812672),(37.21,0.815427),(37.23,0.818182),(37.58,0.820937),(37.85,0.823691),(38.58,0.826446),(39.14,0.829201),(39.55,0.831956),(40.5,0.834711),(40.75,0.837466),(40.84,0.84022),(41,0.842975),(43.28,0.84573),(43.37,0.848485),(45.74,0.85124),(47.81,0.853994),(47.99,0.856749),(48.68,0.859504),(49.79,0.862259),(50.38,0.865014),(50.6,0.867769),(50.7,0.870523),(50.98,0.873278),(51,0.876033),(51.49,0.878788),(56.27,0.881543),(58.07,0.884298),(58.85,0.887052),(60.08,0.889807),(60.86,0.892562),(61.42,0.895317),(65.4,0.898072),(66.18,0.900826),(66.47,0.903581),(66.6,0.906336),(67,0.909091),(68.25,0.911846),(75.94,0.914601),(78.32,0.917355),(79.42,0.92011),(80.52,0.922865),(81,0.92562),(85.89,0.928375),(93.23,0.931129),(98.6,0.933884),(99.03,0.936639),(100.2,0.939394),(100.4,0.942149),(101,0.944904),(106.26,0.947658),(110.16,0.950413),(114.89,0.953168),(120.8,0.955923),(121.03,0.958678),(125.25,0.961433),(126,0.964187),(150.1,0.966942),(155.86,0.969697),(194.76,0.972452),(199.8,0.975207),(229.59,0.977961),(251,0.980716),(382.74,0.983471),(383.51,0.986226),(424.29,0.988981),(425.19,0.991736),(446.59,0.99449),(470.44,0.997245);
/*!40000 ALTER TABLE `fforecast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fform`
--

DROP TABLE IF EXISTS `fform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fform` (
  `FORM` char(40) DEFAULT NULL,
  `SCORE` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fform`
--

LOCK TABLES `fform` WRITE;
/*!40000 ALTER TABLE `fform` DISABLE KEYS */;
INSERT INTO `fform` VALUES ('9',0.72792),('9',0.72792),('99',0.866097),('999699',0.915954),('919319',0.742165),('439519',0.346154),('69',0.571225),('298299',0.188034),('241119',0.135328),('33129',0.226496),('94P999',0.794872),('295699',0.182336),('9799',0.850427),('222799',0.111111),('P12999',0.945869),('999',0.907407),('19999',0.0826211),('9999',0.921652),('999999',0.92735),('992999',0.873219),('465999',0.378917),('486999',0.396011),('7999',0.653846),('588999',0.481481),('133299',0.037037),('544299',0.445869),('789399',0.638177),('495399',0.401709),('123599',0.02849),('696599',0.576923),('99699',0.890313),('599699',0.5),('157799',0.0655271),('5999',0.501424),('3919',0.293447),('327919',0.220798),('999919',0.923077),('94419',0.7849),('911719',0.730769),('558919',0.458689),('224629',0.118234),('899929',0.717949),('529',0.434473),('629',0.52849),('993729',0.877493),('447729',0.354701),('321F29',0.209402),('921P29',0.745014),('39',0.289174),('949239',0.792023),('769439',0.62963),('9839',0.853276),('249',0.150997),('3249',0.217949),('239949',0.131054),('343549',0.246439),('9959',0.884615),('111259',0.00569801),('235359',0.128205),('6359',0.535613),('9P7659',0.934473),('141759',0.0512821),('169859',0.0726496),('511169',0.420228),('748269',0.618234),('561869',0.465812),('7669',0.628205),('799979',0.655271),('9979',0.897436),('935279',0.767806),('79P379',0.656695),('927679',0.753561),('779',0.635328),('89',0.709402),('589',0.482906),('989',0.85755),('245989',0.143875),('759389',0.621083),('244689',0.141026),('99',0.866097),('2U4199',0.196581),('514799',0.424501),('999',0.907407),('995199',0.883191),('561599',0.462963),('6PPF9',0.58547),('9PFP9',0.935897),('1',0.0014245),('1',0.0014245),('245991',0.145299),('845291',0.682336),('927731',0.754986),('141',0.048433),('572141',0.47151),('P34R41',0.952991),('954451',0.804843),('66U451',0.561254),('429651',0.330484),('273361',0.168091),('55911',0.460114),('919131',0.740741),('98P631',0.861823),('246741',0.148148),('442661',0.349003),('775491',0.633903),('631191',0.531339),('687191',0.569801),('11',0.002849),('P84311',0.970085),('99911',0.908832),('362911',0.266382),('431111',0.336182),('492111',0.397436),('995111',0.881766),('1211',0.0242165),('242311',0.139601),('796311',0.643875),('481511',0.393162),('6811',0.568376),('21',0.0897436),('666921',0.555556),('214121',0.0954416),('395121',0.299145),('91221',0.732194),('731421',0.60114),('523131',0.431624),('331',0.225071),('P3331',0.951567),('94431',0.786325),('641',0.538462),('959541',0.81339),('123941',0.0299145),('444141',0.351852),('199841',0.0811966),('U99951',0.997151),('P5P851',0.961538),('379P51',0.280627),('5P4561',0.505698),('976261',0.843305),('461',0.377493),('138461',0.0441595),('4P9561',0.413105),('347861',0.250712),('969971',0.833333),('429371',0.32906),('44P581',0.35755),('955881',0.807692),('7981',0.649573),('44P3P1',0.356125),('4P63P1',0.411681),('2',0.0883191),('312',0.19943),('143522',0.0541311),('9332',0.763533),('942',0.779202),('146542',0.0584046),('52UR52',0.435897),('382392',0.286325),('9692',0.830484),('96P922',0.837607),('21522',0.0997151),('252442',0.155271),('522952',0.430199),('PP9462',0.982906),('894492',0.710826),('975492',0.84188),('992692',0.871795),('998692',0.903134),('844992',0.680912),('228992',0.121083),('12',0.022792),('476912',0.387464),('241412',0.136752),('P25612',0.950142),('417112',0.31339),('924112',0.749288),('246112',0.146724),('646112',0.542735),('291212',0.176638),('119212',0.0213675),('5512',0.452991),('634712',0.534188),('33222',0.22792),('261322',0.163818),('999322',0.910256),('799422',0.652422),('28422',0.172365),('9522',0.801994),('595522',0.494302),('225622',0.119658),('359722',0.262108),('296722',0.183761),('534P22',0.440171),('831532',0.672365),('655132',0.552707),('71232',0.594017),('112232',0.0128205),('432',0.337607),('P67532',0.964387),('912632',0.733618),('546832',0.448718),('42',0.316239),('377642',0.277778),('634442',0.532764),('515642',0.425926),('742',0.611111),('842',0.676638),('747842',0.616809),('971P42',0.840456),('U98852',0.995726),('211452',0.0911681),('535952',0.441595),('7P5452',0.65812),('918362',0.739316),('399762',0.304843),('941862',0.776353),('127482',0.034188),('999792',0.917379),('U451P2',0.991453),('4564P2',0.367521),('5P4BP2',0.508547),('5953U2',0.492877),('2S24U2',0.195157),('3',0.198006),('213913',0.0940171),('1333',0.0384615),('993473',0.874644),('876873',0.702279),('899993',0.720798),('112133',0.011396),('714533',0.595442),('3153',0.203704),('941863',0.777778),('242273',0.138177),('991993',0.87037),('143993',0.0555556),('RU293',0.985755),('964393',0.817664),('867893',0.696581),('985993',0.854701),('13',0.0356125),('F13',0.941595),('U66213',0.994302),('5P9913',0.511396),('P66213',0.962963),('933213',0.764957),('849213',0.68661),('67P313',0.566952),('154413',0.0626781),('929413',0.75641),('513',0.423077),('613',0.518519),('2F2713',0.192308),('3P13',0.306268),('744P13',0.615385),('895423',0.713675),('459123',0.371795),('23123',0.125356),('694123',0.574074),('711223',0.589744),('1PP223',0.0854701),('659423',0.554131),('39523',0.30057),('441623',0.347578),('139623',0.045584),('7U1823',0.662393),('33',0.223647),('333',0.232194),('1U5P33',0.0868946),('59133',0.487179),('791133',0.639601),('742133',0.612536),('649333',0.545584),('52333',0.433048),('923333',0.746439),('486333',0.394587),('913533',0.736467),('668533',0.559829),('P45733',0.957265),('212733',0.0925926),('998833',0.904558),('43',0.334758),('343543',0.245014),('469943',0.381766),('143',0.0527066),('343',0.242165),('341343',0.240741),('111443',0.00712251),('965743',0.820513),('925843',0.750712),('156843',0.0641026),('53',0.438746),('53',0.438746),('125953',0.0327635),('179953',0.0769231),('739153',0.608262),('422153',0.319088),('998353',0.901709),('419853',0.314815),('455F53',0.366097),('P963',0.975783),('947163',0.789174),('499363',0.408832),('251363',0.153846),('716P63',0.596866),('73',0.599715),('954473',0.806268),('844173',0.679487),('224373',0.115385),('425373',0.324786),('773',0.632479),('821F73',0.668091),('199383',0.0797721),('943383',0.782051),('134293',0.042735),('959693',0.814815),('967793',0.824786),('4684F3',0.380342),('9295P3',0.757835),('2939R3',0.180912),('5467U3',0.447293),('4',0.310541),('4',0.310541),('9594',0.811966),('2244',0.116809),('494544',0.39886),('566F44',0.470085),('654',0.549858),('5P2F54',0.504274),('989764',0.858974),('112U64',0.0185185),('969984',0.836182),('313224',0.202279),('94',0.774929),('999994',0.924501),('111494',0.00997151),('911694',0.729345),('8794',0.703704),('121794',0.0270655),('223794',0.112536),('734914',0.605413),('991314',0.868946),('429314',0.327635),('743614',0.61396),('24',0.133903),('798924',0.650997),('954324',0.803419),('435324',0.34188),('424',0.323362),('362934',0.267806),('134',0.0413105),('121134',0.025641),('585134',0.480057),('668234',0.558405),('322334',0.210826),('434',0.340456),('85534',0.693732),('35634',0.25641),('81634',0.666667),('623144',0.519943),('26244',0.165242),('637244',0.537037),('2544',0.15812),('982544',0.851852),('54',0.444444),('497354',0.404558),('268354',0.166667),('257454',0.159544),('3654',0.27208),('923754',0.747863),('33754',0.237892),('297854',0.185185),('7P7P54',0.659544),('598264',0.498576),('33664',0.236467),('69174',0.57265),('674',0.565527),('159974',0.0669516),('967974',0.827635),('5P4984',0.507123),('969984',0.836182),('939584',0.773504),('784',0.636752),('UF8784',0.998576),('459394',0.373219),('P4',0.95584),('9662P4',0.821937),('9193P4',0.74359),('P812U4',0.967236),('5',0.418803),('5',0.418803),('495795',0.403134),('42F625',0.333333),('355',0.254986),('999565',0.91453),('9865',0.856125),('85',0.690883),('91485',0.737892),('5',0.418803),('93715',0.77208),('35',0.253561),('5F7445',0.502849),('95',0.799145),('979795',0.847578),('111195',0.0042735),('645395',0.541311),('796495',0.645299),('219595',0.102564),('969115',0.82906),('214315',0.0982906),('163815',0.0712251),('711915',0.592593),('22215',0.106838),('25',0.152422),('642125',0.539886),('214225',0.0968661),('734225',0.603989),('956925',0.809117),('343225',0.24359),('285425',0.173789),('763825',0.626781),('P825',0.968661),('35',0.253561),('338235',0.239316),('2P7635',0.193732),('423835',0.321937),('P35',0.954416),('45',0.358974),('623945',0.521368),('432345',0.339031),('762345',0.625356),('823545',0.669516),('561845',0.464387),('579955',0.478632),('443255',0.350427),('932555',0.762108),('655',0.551282),('U3P965',0.990029),('365',0.270655),('845365',0.683761),('BP5365',0.938746),('219765',0.103989),('22965',0.122507),('831F65',0.673789),('175975',0.0740741),('6975',0.579772),('4475',0.353276),('99675',0.887464),('391875',0.292023),('85',0.690883),('385',0.287749),('391685',0.290598),('379985',0.279202),('321395',0.207977),('141395',0.0498575),('2311P5',0.123932),('4989P5',0.407407),('6',0.517094),('6',0.517094),('112416',0.0156695),('32516',0.219373),('942346',0.780627),('7966',0.648148),('315676',0.205128),('9P6',0.931624),('451596',0.361823),('936BU6',0.770655),('96',0.816239),('943496',0.783476),('8696',0.69943),('711596',0.591168),('27796',0.17094),('649316',0.54416),('55P416',0.461538),('13P326',0.0470085),('99UP26',0.930199),('577126',0.477208),('PP4226',0.981481),('839426',0.675214),('177526',0.0754986),('36',0.263533),('P99136',0.977208),('896836',0.7151),('99PU36',0.928775),('46',0.376068),('233246',0.126781),('9946',0.878917),('293346',0.179487),('912746',0.735043),('363U46',0.269231),('594456',0.491453),('345556',0.247863),('558156',0.457265),('224266',0.11396),('795266',0.64245),('451566',0.360399),('3566',0.257835),('381866',0.2849),('112276',0.014245),('5476',0.450142),('876',0.700855),('9976',0.894587),('222286',0.109687),('925986',0.752137),('429686',0.331909),('565886',0.468661),('99986',0.920228),('597996',0.497151),('796596',0.646724),('696',0.575499),('7',0.588319),('7',0.588319),('323217',0.2151),('517',0.428775),('451727',0.363248),('516947',0.42735),('8497',0.688034),('3176F7',0.206553),('97',0.839031),('999537',0.911681),('32277',0.212251),('245277',0.14245),('219997',0.105413),('895397',0.712251),('112797',0.017094),('323897',0.216524),('114917',0.019943),('22217',0.108262),('25F217',0.162393),('133317',0.039886),('651617',0.548433),('4PPP17',0.41453),('455927',0.364672),('421127',0.317664),('624227',0.522792),('37',0.274929),('P937',0.972934),('3337',0.233618),('23P337',0.132479),('572537',0.472934),('361737',0.264957),('47',0.384615),('853447',0.692308),('P24147',0.948718),('PPP247',0.98433),('273447',0.169516),('847',0.685185),('322947',0.213675),('PP2P47',0.980057),('3357',0.235043),('457',0.368946),('572557',0.474359),('P957',0.974359),('P4P157',0.958689),('552257',0.454416),('111457',0.00854701),('557',0.45584),('948557',0.790598),('67',0.562678),('967',0.823362),('9967',0.88604),('494967',0.400285),('39967',0.303419),('77',0.631054),('292177',0.178063),('238277',0.12963),('5377',0.44302),('667P77',0.55698),('4987',0.405983),('394187',0.297721),('997197',0.891738),('9P7',0.933048),('5PPPP7',0.514245),('8',0.665242),('8',0.665242),('48',0.391738),('392568',0.294872),('629488',0.529915),('6738',0.564103),('144898',0.0569801),('944F98',0.787749),('9998',0.918803),('297998',0.18661),('991298',0.867521),('759498',0.622507),('41598',0.311966),('9798',0.849003),('998',0.900285),('999998',0.925926),('477218',0.388889),('627518',0.525641),('591128',0.485755),('428128',0.326211),('328',0.222222),('93428',0.766382),('38',0.283476),('38',0.283476),('1F1538',0.0840456),('96938',0.831909),('346638',0.249288),('949738',0.793447),('956938',0.810541),('473948',0.38604),('899948',0.719373),('996758',0.888889),('358',0.259259),('4358',0.343305),('51168',0.421652),('868',0.698006),('793868',0.641026),('422178',0.320513),('9978',0.896011),('994978',0.880342),('14978',0.0612536),('88',0.705128),('U324P8',0.988604),('9',0.72792),('9',0.72792),('733699',0.602564),('997919',0.89886),('9319',0.760684),('397449',0.301994),('247999',0.149573),('148619',0.0598291),('97699',0.844729),('8P14P9',0.722222),('99',0.866097),('58F299',0.48433),('699999',0.581197),('92U999',0.759259),('19',0.0783476),('842129',0.678063),('597129',0.495726),('3P8429',0.307692),('829',0.67094),('95139',0.80057),('439',0.344729),('332949',0.230769),('499449',0.410256),('5649',0.467236),('749',0.619658),('162959',0.0683761),('259',0.160969),('459',0.37037),('3659',0.273504),('99759',0.893162),('U49969',0.992877),('469969',0.383191),('737169',0.606838),('858679',0.695157),('935779',0.769231),('299979',0.190883),('9679',0.826211),('979',0.846154),('89',0.709402),('592589',0.490029),('8999',0.716524),('312299',0.200855),('289999',0.175214),('5493P9',0.451567),('7PP2B',0.660969),('696B',0.578348),('35863F',0.260684),('98999F',0.860399),('88653F',0.706553),('253F',0.156695),('62424F',0.524217),('99955F',0.913105),('3927F',0.296296),('45PP7F',0.374644),('enoN',0.940171),('P',0.944444),('P',0.944444),('33272P',0.229345),('21811P',0.10114),('73PP2P',0.609687),('99368P',0.876068),('PP',0.978632),('U2329P',0.987179),('47919P',0.390313),('5P9P',0.512821),('P8771P',0.97151),('6P2P',0.584046),('16373P',0.0698006),('62783P',0.527066),('94R34P',0.796296),('964P',0.819088),('29964P',0.189459),('59255P',0.488604),('P1415P',0.947293),('75985P',0.623932),('1257P',0.031339),('64F88P',0.547009),('P559PP',0.960114),('94U8PP',0.797721),('5743UP',0.475783),('9U',0.937322),('P6FP1U',0.965812),('72U13U',0.598291),('69P44U',0.582621),('375U',0.276353),('5P677U',0.509971);
/*!40000 ALTER TABLE `fform` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-12 20:56:04