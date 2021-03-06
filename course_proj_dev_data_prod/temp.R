library(caret)
data <- data.frame(
#  id = c(85,  86,	87,	88,	89,	91,	92,	93,	94,	95,	96,	97,	98,	99,	100,	101,	102,	103,	104,	105,	106,	107,	108,	109,	111,	112,	113,	114,	115,	116,	117,	118,	119,	120,	121,	123,	124,	125,	126,	127,	128,	129,	130,	131,	132,	133,	134,	135,	136,	137,	138,	139,	140,	141,	142,	143,	144,	145,	146,	147,	148,	149,	150,	151,	154,	155,	156,	159,	160,	161,	162,	163,	164,	166,	167,	168,	169,	170,	172,	173,	174,	175,	176,	177,	179,	180,	181,	182,	183,	184,	185,	186,	187,	188,	189,	190,	191,	192,	193,	195,	196,	197,	199,	200,	201,	202,	203,	204,	205,	206,	207,	208,	209,	210,	211,	212,	213,	214,	215,	216,	217,	218,	219,	220,	221,	222,	223,	224,	225,	226,	4,	10,	11,	13,	15,	16,	17,	18,	19,	20,	22,	23,	24,	25,	26,	27,	28,	29,	30,	31,	32,	33,	34,	35,	36,	37,	40,	42,	43,	44,	45,	46,	47,	49,	50,	51,	52,	54,	56,	57,	59,	60,	61,	62,	63,	65,	67,	68,	69,	71,	75,	76,	77,	78,	79,	81,	82,	83,	84),
#  low = c(0,  0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1),
  age = c(19,  33,	20,	21,	18,	21,	22,	17,	29,	26,	19,	19,	22,	30,	18,	18,	15,	25,	20,	28,	32,	31,	36,	28,	25,	28,	17,	29,	26,	17,	17,	24,	35,	25,	25,	29,	19,	27,	31,	33,	21,	19,	23,	21,	18,	18,	32,	19,	24,	22,	22,	23,	22,	30,	19,	16,	21,	30,	20,	17,	17,	23,	24,	28,	26,	20,	24,	28,	20,	22,	22,	31,	23,	16,	16,	18,	25,	32,	20,	23,	22,	32,	30,	20,	23,	17,	19,	23,	36,	22,	24,	21,	19,	25,	16,	29,	29,	19,	19,	30,	24,	19,	24,	23,	20,	25,	30,	22,	18,	16,	32,	18,	29,	33,	20,	28,	14,	28,	25,	16,	20,	26,	21,	22,	25,	31,	35,	19,	24,	45,	28,	29,	34,	25,	25,	27,	23,	24,	24,	21,	32,	19,	25,	16,	25,	20,	21,	24,	21,	20,	25,	19,	19,	26,	24,	17,	20,	22,	27,	20,	17,	25,	20,	18,	18,	20,	21,	26,	31,	15,	23,	20,	24,	15,	23,	30,	22,	17,	23,	17,	26,	20,	26,	14,	28,	14,	23,	17,	21),
  lastweight= c(182,  155,	105,	108,	107,	124,	118,	103,	123,	113,	95,	150,	95,	107,	100,	100,	98,	118,	120,	120,	121,	100,	202,	120,	120,	167,	122,	150,	168,	113,	113,	90,	121,	155,	125,	140,	138,	124,	215,	109,	185,	189,	130,	160,	90,	90,	132,	132,	115,	85,	120,	128,	130,	95,	115,	110,	110,	153,	103,	119,	119,	119,	110,	140,	133,	169,	115,	250,	141,	158,	112,	150,	115,	112,	135,	229,	140,	134,	121,	190,	131,	170,	110,	127,	123,	120,	105,	130,	175,	125,	133,	134,	235,	95,	135,	135,	154,	147,	147,	137,	110,	184,	110,	110,	120,	241,	112,	169,	120,	170,	186,	120,	130,	117,	170,	134,	135,	130,	120,	95,	158,	160,	115,	129,	130,	120,	170,	120,	116,	123,	120,	130,	187,	105,	85,	150,	97,	128,	132,	165,	105,	91,	115,	130,	92,	150,	200,	155,	103,	125,	89,	102,	112,	117,	138,	130,	120,	130,	130,	80,	110,	105,	109,	148,	110,	121,	100,	96,	102,	110,	187,	122,	105,	115,	120,	142,	130,	120,	110,	120,	154,	105,	190,	101,	95,	100,	94,	142,	130),
  race = c (2,  3,	1,	1,	1,	3,	1,	3,	1,	1,	3,	3,	3,	3,	1,	1,	2,	1,	3,	1,	3,	1,	1,	3,	3,	1,	1,	1,	2,	2,	2,	1,	2,	1,	2,	1,	1,	1,	1,	1,	2,	1,	2,	1,	1,	1,	1,	3,	1,	3,	1,	3,	1,	1,	3,	3,	3,	3,	3,	3,	3,	3,	3,	1,	3,	3,	3,	3,	1,	2,	1,	3,	3,	2,	1,	2,	1,	1,	2,	1,	1,	1,	3,	3,	3,	3,	3,	1,	1,	1,	1,	3,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	3,	1,	3,	2,	1,	1,	1,	2,	1,	3,	1,	1,	1,	3,	1,	3,	1,	3,	1,	3,	1,	1,	1,	1,	1,	1,	1,	1,	3,	1,	2,	3,	3,	3,	3,	2,	3,	1,	1,	1,	3,	3,	1,	1,	2,	1,	3,	3,	3,	1,	1,	1,	1,	3,	2,	1,	2,	3,	1,	3,	3,	3,	2,	1,	3,	3,	1,	1,	2,	2,	2,	3,	3,	1,	1,	1,	1,	2,	3,	3,	1,	3,	1,	3,	3,	2,	1),
  smoke =c(0,  0,	1,	1,	1,	0,	0,	0,	1,	1,	0,	0,	0,	0,	1,	1,	0,	1,	0,	1,	0,	0,	0,	0,	0,	0,	1,	0,	1,	0,	0,	1,	1,	0,	0,	1,	1,	1,	1,	1,	1,	0,	0,	0,	1,	1,	0,	0,	0,	1,	0,	0,	1,	1,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	0,	0,	1,	1,	1,	0,	1,	0,	0,	1,	1,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	1,	1,	1,	0,	0,	1,	1,	0,	0,	1,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	1,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	0,	1,	0,	0,	0,	0,	0,	0,	1,	1,	1,	0,	0,	1,	1,	0,	1,	0,	0,	0,	0,	1,	1,	0,	1,	1,	1,	0,	1,	1,	0,	0,	0,	1,	1,	0,	0,	1,	0,	1,	1,	1,	0,	0,	1,	1,	1,	1,	0,	0,	0,	1,	1,	1,	0,	1,	0,	1),
  histprematlabour = c(0,  0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	2,	1,	0,	0,	2,	1,	2,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	3,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	1,	0,	0,	1,	0,	0,	0,	1,	0,	0,	0,	2,	0,	0,	0,	0,	0,	1,	0,	0,	2,	0,	0,	1,	0,	1,	0,	1,	0,	0,	0,	1,	0,	0,	1,	1,	1,	0,	1,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	0,	1,	0,	0,	1,	0,	0,	0,	0,	0),
  histhyper = c(0,  0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	1,	0,	0,	0,	0,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	1,	1),
  uterirr = c(1,  0,	0,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0,	1,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1,	1,	0,	0,	1,	0,	1,	0,	0,	0,	0,	1,	0,	0,	0,	0,	1,	0,	0,	1,	0,	0,	1,	0,	0,	1,	0,	1,	1,	1,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
  visitsfirsttrim = c(0,  3,	1,	2,	0,	0,	1,	1,	1,	0,	0,	1,	0,	2,	0,	0,	0,	3,	0,	1,	2,	3,	1,	0,	2,	0,	0,	2,	0,	1,	1,	1,	1,	1,	0,	2,	2,	0,	2,	1,	2,	2,	1,	0,	0,	0,	4,	0,	2,	0,	1,	0,	0,	2,	0,	0,	0,	0,	0,	0,	0,	2,	0,	0,	0,	1,	2,	6,	1,	2,	0,	2,	1,	0,	0,	0,	1,	4,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	2,	0,	0,	0,	1,	1,	0,	0,	1,	1,	0,	0,	1,	0,	0,	1,	0,	2,	4,	2,	1,	2,	1,	0,	1,	0,	0,	2,	1,	1,	0,	1,	0,	2,	2,	1,	0,	1,	1,	0,	2,	0,	0,	0,	0,	1,	1,	0,	1,	0,	0,	0,	1,	0,	2,	2,	0,	0,	0,	1,	2,	0,	0,	0,	0,	3,	1,	0,	0,	0,	1,	0,	0,	0,	0,	4,	0,	1,	0,	1,	0,	0,	0,	0,	0,	1,	3,	0,	2,	1,	3,	0,	0,	2,	2,	0,	0,	3),
  birthweight = c(2523,  2551,	2557,	2594,	2600,	2622,	2637,	2637,	2663,	2665,	2722,	2733,	2750,	2750,	2769,	2769,	2778,	2782,	2807,	2821,	2835,	2835,	2836,	2863,	2877,	2877,	2906,	2920,	2920,	2920,	2920,	2948,	2948,	2977,	2977,	2977,	2977,	2992,	3005,	3033,	3042,	3062,	3062,	3062,	3076,	3076,	3080,	3090,	3090,	3090,	3100,	3104,	3132,	3147,	3175,	3175,	3203,	3203,	3203,	3225,	3225,	3232,	3232,	3234,	3260,	3274,	3274,	3303,	3317,	3317,	3317,	3321,	3331,	3374,	3374,	3402,	3416,	3430,	3444,	3459,	3460,	3473,	3475,	3487,	3544,	3572,	3572,	3586,	3600,	3614,	3614,	3629,	3629,	3637,	3643,	3651,	3651,	3651,	3651,	3699,	3728,	3756,	3770,	3770,	3770,	3790,	3799,	3827,	3856,	3860,	3860,	3884,	3884,	3912,	3940,	3941,	3941,	3969,	3983,	3997,	3997,	4054,	4054,	4111,	4153,	4167,	4174,	4238,	4593,	4990,	709,	1021,	1135,	1330,	1474,	1588,	1588,	1701,	1729,	1790,	1818,	1885,	1893,	1899,	1928,	1928,	1928,	1936,	1970,	2055,	2055,	2082,	2084,	2084,	2100,	2125,	2126,	2187,	2187,	2211,	2225,	2240,	2240,	2282,	2296,	2296,	2301,	2325,	2353,	2353,	2367,	2381,	2381,	2381,	2395,	2410,	2410,	2414,	2424,	2438,	2442,	2450,	2466,	2466,	2466,	2495,	2495,	2495,	2495)
  )
#data$low <- as.factor(data$low)
data$race <- as.factor(data$race)
data$smoke <- as.factor(data$smoke)
data$histprematlabour <- as.factor(data$histprematlabour)
data$histhyper <- as.factor(data$histhyper)
data$uterirr <- as.factor(data$uterirr)
set.seed(62433)
inTrain = createDataPartition(data$birthweight, p = 3/4)[[1]]
trainData = data[inTrain,]
testData = data[-inTrain,]
print("fit here")
modfit_rf <- train(birthweight ~ ., method  = 'rf', data = trainData)
testData$pred_bw <- predict(modfit_rf, newdata = testData)
testData$diff <- testData[,c("birthweight")] - testData[,c("pred_bw")]
standdev <- sd(testData$diff)
print("deviation")
print(standdev)
participant1 <- data.frame(
  age = c(19), 
  lastweight= c(200), #pounds
  race = c (3), # Race (1 = White, 2 = Black, 3 = Other)
  smoke =c(0),
  histprematlabour = c(0),
  histhyper = c(0),
  uterirr = c(0),
  visitsfirsttrim = c(3)
  )
participant1$race <- as.factor(participant1$race)
participant1$smoke <- as.factor(participant1$smoke)
participant1$histprematlabour <- as.factor(participant1$histprematlabour)
participant1$histhyper <- as.factor(participant1$histhyper)
participant1$uterirr <- as.factor(participant1$uterirr)

participant2 <- data.frame(
  age = c(25), 
  lastweight= c(200), #pounds
  race = c (1), # Race (1 = White, 2 = Black, 3 = Other)
  smoke =c(1),
  histprematlabour = c(1),
  histhyper = c(1),
  uterirr = c(1),
  visitsfirsttrim = c(1)
)
participant2$race <- as.factor(participant2$race)
participant2$smoke <- as.factor(participant2$smoke)
participant2$histprematlabour <- as.factor(participant2$histprematlabour)
participant2$histhyper <- as.factor(participant2$histhyper)
participant2$uterirr <- as.factor(participant2$uterirr)



part1_pred <- predict(modfit_rf, newdata = participant1)
part2_pred <- predict(modfit_rf, newdata = participant2)
print("test")
print(part1_pred)
print(part2_pred)
