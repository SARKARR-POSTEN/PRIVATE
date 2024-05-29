DECLARE
  lv_procedure_name VARCHAR2(200) := 'refresh_main';
  lv_error_msg      VARCHAR2(2000);
  lv_stage          VARCHAR2(200);
  l_party_id        NUMBER;
  e_error           EXCEPTION;
  lv_duns_number    VARCHAR2(200);
  x_cre_ret         NUMBER;
  X_CRE_MSG         VARCHAR2(2000);
  V_ORG_NAME        VARCHAR2(30);
  T_ORG_NO          VARCHAR2(200);
  CURSOR CUR_ORG_NUMBER
  IS
    SELECT JGZZ_FISCAL_CODE,
      DUNS_NUMBER,
      COUNTRY,
      ATTRIBUTE17
    FROM HZ_PARTIES
    WHERE 1 = 1
      --AND Attribute7 = 'Y'
    AND STATUS = 'A'
    AND DECODE (PARTY_ID,22602505,1, 22602506,1, 22602507,1, 22602508,1, 22602509,1, 22602510,1, 22602511,1, 22602512,1, 22602513,1, 22602514,1, 22602515,1, 22602516,1, 22602517,1, 22602518,1, 22602519,1, 22602520,1, 22602521,1, 22602522,1, 22602523,1, 22602524,1, 22602525,1, 22602526,1, 22602527,1, 22602528,1, 22602529,1, 22602530,1, 22602531,1, 22602533,1, 22602534,1, 22602535,1, 22602536,1, 22602537,1, 22602538,1, 22602539,1, 22602540,1, 22602541,1, 22602542,1, 22602543,1, 22602544,1, 22602545,1, 22602546,1, 22602547,1, 22602548,1, 22602549,1, 22602551,1, 22602552,1, 22602553,1, 22602554,1, 22602555,1, 22602556,1, 22602557,1, 22602558,1, 22602559,1, 22602561,1, 22602562,1, 22602563,1, 22602565,1, 22602567,1, 22602568,1, 22602569,1, 22602570,1, 22602571,1, 22602572,1, 22602573,1, 22602574,1, 22602575,1, 22602576,1, 22602577,1, 22602578,1, 22602579,1, 22602581,1, 22602582,1, 22602583,1, 22602584,1, 22602585,1, 22602586,1, 22602587,1, 22602588,1, 22602589,1, 22602590,1, 22602591,1,
      22602592,1, 22602593,1, 22602595,1, 22602596,1, 22602597,1, 22602598,1, 22602599,1, 22602600,1, 22602602,1, 22602603,1, 22602604,1, 22602606,1, 22602607,1, 22602608,1, 22602609,1, 22602611,1, 22602612,1, 22602613,1, 22602614,1, 22602615,1, 22602616,1, 22602617,1, 22602618,1, 22602619,1, 22602621,1, 22602622,1, 22602623,1, 22602624,1, 22602625,1, 22602627,1, 22602628,1, 22602629,1, 22602630,1, 22602631,1, 22602632,1, 22602633,1, 22602634,1, 22602636,1, 22602637,1, 22602638,1, 22602639,1, 22602640,1, 22602641,1, 22602642,1, 22602643,1, 22602644,1, 22602645,1, 22602647,1, 22602648,1, 22602649,1, 22602650,1, 22602651,1, 22602652,1, 22602653,1, 22602654,1, 22602655,1, 22602657,1, 22602658,1, 22602659,1, 22602660,1, 22602661,1, 22602662,1, 22602664,1, 22602665,1, 22602666,1, 22602667,1, 22602668,1, 22602669,1, 22602670,1, 22602672,1, 22602673,1, 22602674,1, 22602675,1, 22602676,1, 22602677,1, 22602678,1, 22602679,1, 22602680,1, 22602682,1, 22602683,1, 22602684,1, 22602685,1, 22602686
      ,1, 22602687,1, 22602688,1, 22602689,1, 22602690,1, 22602692,1, 22602693,1, 22602694,1, 22602695,1, 22602696,1, 22602697,1, 22602698,1, 22602699,1, 22602701,1, 22602702,1, 22602703,1, 22602704,1, 22602705,1, 22602706,1, 22602707,1, 22602708,1, 22602709,1, 22602710,1, 22602712,1, 22602713,1, 22602714,1, 22602715,1, 22602716,1, 22602717,1, 22602718,1, 22602719,1, 22602720,1, 22602721,1, 22602722,1, 22602723,1, 22602725,1, 22602726,1, 22602727,1, 22602728,1, 22602729,1, 22602730,1, 22602731,1, 22602732,1, 22602734,1, 22602735,1, 22602736,1, 22602737,1, 22602738,1, 22602739,1, 22602740,1, 22602741,1, 22602742,1, 22602744,1, 22602745,1, 22602746,1, 22602747,1, 22602748,1, 22602749,1, 22602750,1, 22602751,1, 22602752,1, 22602753,1, 22602754,1, 22602755,1, 22602756,1, 22602757,1, 22602758,1, 22602759,1, 22602760,1, 22602761,1, 22602762,1, 22602763,1, 22602764,1, 22602765,1, 22602766,1, 22602767,1, 22602768,1, 22602769,1, 22602770,1, 22602771,1, 22602772,1, 22603502,1, 22603503,1,
      22604503,1, 22604504,1, 22604506,1, 22604507,1, 22604508,1, 22604509,1, 22604511,1, 22604512,1, 22604513,1, 22604514,1, 22604515,1, 22604516,1, 22604517,1, 22604518,1, 22604519,1, 22604521,1, 22604522,1, 22604523,1, 22604524,1, 22604525,1, 22604526,1, 22604527,1, 22604528,1, 22604529,1, 22604530,1, 22604531,1, 22604533,1, 22604534,1, 22604535,1, 22604537,1, 22604538,1, 22604539,1, 22604540,1, 22604541,1, 22604542,1, 22604543,1, 22604544,1, 22604545,1, 22604546,1, 22604548,1, 22604549,1, 22604550,1, 22604551,1, 22604552,1, 22604553,1, 22604554,1, 22604555,1, 22604556,1, 22605502,1, 22605503,1, 22606502,1, 22606504,1, 22606505,1, 22606506,1, 22606507,1, 22606508,1, 22606509,1, 22606510,1, 22606511,1, 22606513,1, 22606514,1, 22606515,1, 22606516,1, 22606517,1, 22606518,1, 22606519,1, 22606520,1, 22606522,1, 22606523,1, 22606524,1, 22606525,1, 22606526,1, 22606527,1, 22606528,1, 22606529,1, 22606530,1, 22606531,1, 22606533,1, 22606534,1, 22606535,1, 22606536,1, 22606537,1, 22606538
      ,1, 22606539,1, 22606540,1, 22606541,1, 22606542,1, 22606543,1, 22606544,1, 22606546,1, 22606547,1, 22606548,1, 22606549,1, 22606550,1, 22606551,1, 22606552,1, 22606553,1, 22606554,1, 22606555,1, 22606556,1, 22606558,1, 22606559,1, 22606560,1, 22606561,1, 22606562,1, 22606563,1, 22606564,1, 22606565,1, 22606566,1, 22606567,1, 22606568,1, 22606569,1, 22606571,1, 22606572,1, 22606573,1, 22606574,1, 22606575,1, 22606576,1, 22606577,1, 22606578,1, 22606579,1, 22606580,1, 22606581,1, 22606582,1, 22606584,1, 22606585,1, 22606586,1, 22606587,1, 22606588,1, 22606589,1, 22606590,1, 22606591,1, 22606592,1, 22606593,1, 22606594,1, 22606595,1, 22606596,1, 22606598,1, 22606599,1, 22606600,1, 22606601,1, 22606602,1, 22606603,1, 22606604,1, 22606605,1, 22606606,1, 22606607,1, 22606609,1, 22606610,1, 22606611,1, 22606612,1, 22607502,1, 22607503,1, 22608502,1, 22608503,1, 22608505,1, 22608506,1, 22608507,1, 22608508,1, 22608509,1, 22608510,1, 22608511,1, 22608512,1, 22608513,1, 22608515,1,
      22608516,1, 22608517,1, 22608518,1, 22608521,1, 22608522,1, 22608523,1, 22608524,1, 22608525,1, 22608526,1, 22608527,1, 22608528,1, 22608529,1, 22608530,1, 22608532,1, 22608533,1, 22608534,1, 22608535,1, 22608536,1, 22608537,1, 22608539,1, 22608540,1, 22608541,1, 22608542,1, 22608543,1, 22608544,1, 22608545,1, 22608546,1, 22608548,1, 22608549,1, 22608550,1, 22608551,1, 22608552,1, 22608554,1, 22608555,1, 22608556,1, 22608557,1, 22608559,1, 22608560,1, 22608561,1, 22608562,1, 22608563,1, 22608564,1, 22608565,1, 22608566,1, 22608567,1, 22608569,1, 22608570,1, 22608571,1, 22608572,1, 22608573,1, 22608574,1, 22608575,1, 22608577,1, 22608578,1, 22608579,1, 22608580,1, 22608581,1, 22608582,1, 22608583,1, 22608584,1, 22608586,1, 22608587,1, 22608588,1, 22608589,1, 22608590,1, 22608591,1, 22608592,1, 22608593,1, 22608594,1, 22608596,1, 22608598,1, 22608599,1, 22608600,1, 22608601,1, 22608602,1, 22608603,1, 22608605,1, 22608606,1, 22608607,1, 22608609,1, 22608610,1, 22608611,1,     22608612,1, 22608614,1, 22608615,1, 22608616,1, 22608617,1, 22608618,1, 22608619,1, 22608620,1, 22608621,1, 22608622,1, 22608623,1, 22608625,1, 22608626,1, 22608627,1, 22608628,1, 22608629,1, 22608630,1, 22608631,1, 22608632,1, 22608634,1, 22608635,1, 22608636,1, 22608637,1, 22608638,1, 22608639,1, 22608640,1, 22608641,1, 22608642,1, 22608644,1, 22608645,1, 22608646,1, 22608647,1, 22608648,1, 22608650,1, 22608651,1, 22608652,1, 22608653,1, 22608654,1, 22608655,1, 22608656,1, 22608657,1, 22608658,1, 22608659,1, 22608661,1, 22608662,1, 22608663,1, 22608664,1, 22608665,1, 22608666,1, 22608667,1, 22608668,1, 22608669,1, 22608670,1, 22608672,1, 22608673,1, 22608674,1, 22608675,1, 22608676,1, 22608677,1, 22608678,1, 22608680,1, 22608681,1, 22608682,1, 22608683,1, 22608684,1, 22608686,1, 22608687,1, 22608688,1, 22608689,1, 22608691,1, 22608692,1, 22608693,1, 22608694,1, 22608695,1, 22608698,1, 22608700,1, 22608701,1, 22608702,1, 22608703,1, 22608704,1, 22608705,1, 22608706,1,
      22608707,1, 22608708,1, 22608709,1, 22608711,1, 22608712,1, 22608713,1, 22608714,1, 22608715,1, 22608716,1, 22608717,1, 22608718,1, 22608720,1, 22608721,1, 22608722,1, 22608723,1, 22608724,1, 22608725,1, 22608727,1, 22608728,1, 22608729,1, 22608730,1, 22608731,1, 22608733,1, 22608734,1, 22608735,1, 22608736,1, 22608737,1, 22608738,1, 22608739,1, 22608740,1, 22608741,1, 22608742,1, 22608743,1, 22608744,1, 22608745,1, 22608746,1, 22608748,1, 22608749,1, 22608750,1, 22608751,1, 22608752,1, 22608753,1, 22608754,1, 22608755,1, 22608756,1, 22608758,1, 22608759,1, 22608760,1, 22608761,1, 22608762,1, 22608763,1, 22608764,1, 22608765,1, 22608766,1, 22608767,1, 22608769,1, 22608770,1, 22608771,1, 22608772,1, 22608773,1, 22608774,1, 22608775,1, 22608776,1, 22608778,1, 22608779,1, 22608780,1, 22608781,1, 22608782,1, 22608783,1, 22608784,1, 22608785,1, 22608786,1, 22608788,1, 22608789,1, 22608791,1, 22608792,1, 22608793,1, 22608794,1, 22608795,1, 22608796,1, 22608797,1, 22608798,1, 22608799
      ,1, 22608801,1, 22608802,1, 22608803,1, 22608804,1, 22608805,1, 22608806,1, 22608807,1, 22608808,1, 22608809,1, 22608810,1, 22608812,1, 22608813,1, 22608814,1, 22608815,1, 22608817,1, 22608818,1, 22608819,1, 22608820,1, 22608822,1, 22608823,1, 22608824,1, 22608825,1, 22608826,1, 22608827,1, 22608828,1, 22608829,1, 22608830,1, 22608831,1, 22608832,1, 22608833,1, 22608835,1, 22608836,1, 22608837,1, 22608838,1, 22608839,1, 22608840,1, 22608841,1, 22608842,1, 22608844,1, 22608845,1, 22608846,1, 22608847,1, 22608848,1, 22608849,1, 22608850,1, 22608851,1, 22608852,1, 22608854,1, 22608855,1, 22608856,1, 22608857,1, 22608858,1, 22608859,1, 22608860,1, 22608863,1, 22608864,1, 22608865,1, 22608866,1, 22608867,1, 22608868,1, 22608869,1, 22608870,1, 22608871,1, 22608872,1, 22608873,1, 22608887,1, 22608888,1, 22608890,1, 22608891,1, 22608892,1, 22608893,1, 22608894,1, 22608895,1, 22608896,1, 22608897,1, 22608899,1, 22608900,1, 22608901,1, 22608902,1, 22608903,1, 22608904,1, 22608905,1,
      22608906,1, 22608908,1, 22608909,1, 22636326,1, 22636327,1, 22636328,1, 22636329,1, 22636330,1, 22636331,1, 22636332,1, 22636333,1, 22636334,1, 22636335,1, 22636336,1, 22636337,1, 22636338,1, 22636339,1, 22636340,1, 22636342,1, 22636343,1, 22636344,1, 22636345,1, 22636346,1, 22636347,1, 22636348,1, 22636349,1, 22636350,1, 22636351,1, 22636352,1, 22636353,1, 22636354,1, 22636355,1, 22636356,1, 22636357,1, 22636358,1, 22636361,1, 22636362,1, 22636363,1, 22636364,1, 22636365,1, 22636366,1, 22636367,1, 22636368,1, 22636370,1, 22636371,1, 22636372,1, 22636373,1, 22636374,1, 22636375,1, 22636376,1, 22636377,1, 22636378,1, 22636379,1, 22636380,1, 22636382,1, 22636383,1, 22636384,1, 22636385,1, 22636386,1, 22636387,1, 22636389,1, 22636391,1, 22636392,1, 22636393,1, 22636394,1, 22636395,1, 22636396,1, 22636397,1, 22636398,1, 22636399,1, 22636400,1, 22636401,1, 22636403,1, 22636404,1, 22636405,1, 22636406,1, 22636407,1, 22636408,1, 22636410,1, 22636411,1, 22636412,1, 22636413,1, 22636414
      ,1, 22636415,1, 22636416,1, 22636419,1, 22636420,1, 22636421,1, 22636422,1, 22636423,1, 22636424,1, 22636425,1, 22636426,1, 22636427,1, 22636428,1, 22636429,1, 22636430,1, 22636431,1, 22636432,1, 22636433,1, 22636434,1, 22636435,1, 22636436,1, 22636437,1, 22636438,1, 22636439,1, 22636440,1, 22636441,1, 22636442,1, 22636445,1, 22636446,1, 22636447,1, 22636448,1, 22636449,1, 22636450,1, 22636451,1, 22636452,1, 22636453,1, 22636455,1, 22636456,1, 22636457,1, 22636458,1, 22636459,1, 22636461,1, 22636462,1, 22636463,1, 22636464,1, 22636465,1, 22636466,1, 22636467,1, 22636468,1, 22636470,1, 22636471,1, 22636472,1, 22636473,1, 22636474,1, 22636475,1, 22636476,1, 22636477,1, 22636478,1, 22636480,1, 22636481,1, 22636482,1, 22636483,1, 22636484,1, 22636485,1, 22636486,1, 22636487,1, 22636489,1, 22636490,1, 22636491,1, 22636492,1, 22636494,1, 22636495,1, 22636496,1, 22636497,1, 22636498,1, 22636499,1, 22636500,1, 22636501,1, 22636502,1, 22636504,1, 22636505,1, 22636506,1, 22636507,1,
      22636508,1, 22636509,1, 22636510,1, 22636511,1, 22636512,1, 22636513,1, 22636515,1, 22636516,1, 22636517,1, 22636518,1, 22636519,1, 22636520,1, 22636521,1, 22636522,1, 22636524,1, 22636525,1, 22636526,1, 22636527,1, 22636528,1, 22636529,1, 22636530,1, 22636531,1, 22636532,1, 22636534,1, 22636535,1, 22636536,1, 22636537,1, 22636538,1, 22636539,1, 22636540,1, 22636541,1, 22636542,1, 22636544,1, 22636545,1, 22636546,1, 22636547,1, 22636548,1, 22636549,1, 22636550,1, 22636551,1, 22636552,1, 22636554,1, 22636555,1, 22636556,1, 22636557,1, 22636558,1, 22636560,1, 22636561,1, 22636562,1, 22636563,1, 22636565,1, 22636566,1, 22636567,1, 22636568,1, 22636569,1, 22636570,1, 22636571,1, 22636572,1, 22636573,1, 22636574,1, 22636576,1, 22636577,1, 22636578,1, 22636579,1, 22636580,1, 22636581,1, 22636582,1, 22636583,1, 22636584,1, 22636586,1, 22636587,1, 22636588,1, 22636589,1, 22636591,1, 22636592,1, 22636593,1, 22636594,1, 22636595,1, 22636596,1, 22636597,1, 22636598,1, 22636599,1, 22636600
      ,1, 22636602,1, 22636603,1, 22636604,1, 22636605,1, 22636606,1, 22636607,1, 22636608,1, 22636609,1, 22636610,1, 22636611,1, 22636612,1, 22636613,1, 22636615,1, 22636616,1, 22636617,1, 22636618,1, 22636619,1, 22636621,1, 22636622,1, 22636623,1, 22636624,1, 22636625,1, 22636626,1, 22636627,1, 22636628,1, 22636629,1, 22636630,1, 22636631,1, 22636632,1, 22636634,1, 22636635,1, 22636636,1, 22636637,1, 22636638,1, 22636639,1, 22636640,1, 22636641,1, 22636642,1, 22636643,1, 22636644,1, 22636646,1, 22636647,1, 22636648,1, 22636649,1, 22636650,1, 22636651,1, 22636652,1, 22636653,1, 22636655,1, 22636656,1, 22636657,1, 22636658,1, 22636659,1, 22636660,1, 22636661,1, 22636662,1, 22636663,1, 22636664,1, 22636665,1, 22636667,1, 22636668,1, 22636669,1, 22636670,1, 22636671,1, 22636672,1, 22636673,1, 22636674,1, 22636675,1, 22636676,1, 22636677,1, 22636679,1, 22636680,1, 22636681,1, 22636682,1, 22636683,1, 22636684,1, 22636686,1, 22636687,1, 22636688,1, 22636689,1, 22636690,1, 22636691,1,
      22636692,1, 22636693,1, 22636694,1, 22636695,1, 22636697,1, 22636698,1, 22636699,1, 22636700,1, 22636701,1, 22636702,1, 22636703,1, 22636704,1, 22636706,1, 22636707,1, 22636708,1, 22636709,1, 22636710,1, 22636711,1, 22636712,1, 22636713,1, 22636716,1, 22636717,1, 22636718,1, 22636719,1, 22636720,1, 22636721,1, 22636722,1, 22636723,1, 22636725,1, 22636726,1, 22636727,1, 22636728,1, 22636729,1, 22636730,1, 22636731,1, 22636732,1, 22636733,1, 22636734,1, 22636736,1, 22636737,1, 22636738,1, 22636739,1, 22636740,1, 22636741,1, 22636742,1, 22636744,1, 22636745,1, 22636746,1, 22636747,1, 22636748,1, 22636750,1, 22636751,1, 22636752,1, 22636753,1, 22636754,1, 22636755,1, 22636756,1, 22636757,1, 22636758,1, 22636760,1, 22636761,1, 22636762,1, 22636763,1, 22636764,1, 22636766,1, 22636767,1, 22636768,1, 22636769,1, 22636770,1, 22636771,1, 22636772,1, 22636773,1, 22636774,1, 22636776,1, 22636777,1, 22636778,1, 22636779,1, 22636780,1, 22636781,1, 22636782,1, 22636784,1, 22636785,1, 22636786
      ,1, 22636787,1, 22636788,1, 22636789,1, 22636790,1, 22636792,1, 22636793,1, 22636794,1, 22636795,1, 22636796,1, 22636797,1, 22636798,1, 22636799,1, 22636800,1, 22636801,1, 22636803,1, 22636804,1, 22636805,1, 22636806,1, 22636807,1, 22636808,1, 22636809,1, 22636810,1, 22636811,1, 22636812,1, 22636813,1, 22636815,1, 22636816,1, 22636817,1, 22636818,1, 22636819,1, 22636820,1, 22636821,1, 22636822,1, 22636823,1, 22636824,1, 22636825,1, 22636827,1, 22636828,1, 22636829,1, 22636830,1, 22636831,1, 22636832,1, 22636833,1, 22636834,1, 22636835,1, 22636836,1, 22636837,1, 22636839,1, 22636840,1, 22636841,1, 22636842,1, 22636843,1, 22636844,1, 22636845,1, 22636846,1, 22636847,1, 22636848,1, 22636850,1, 22636851,1, 22636853,1, 22636854,1, 22636855,1, 22636856,1, 22636857,1, 22636858,1, 22636859,1, 22636860,1, 22636862,1, 22636863,1, 22636864,1, 22636865,1, 22636866,1, 22636867,1, 22636868,1, 22636869,1, 22636870,1, 22636871,1, 22636872,1, 22636873,1, 22636875,1, 22636876,1, 22636877,1,
      22636878,1, 22636879,1, 22636880,1, 22636881,1, 22636882,1, 22636883,1, 22636884,1, 22636886,1, 22636887,1, 22636888,1, 22636889,1, 22636890,1, 22636891,1, 22636892,1, 22636893,1, 22636894,1, 22636895,1, 22636896,1, 22636898,1, 22636899,1, 22636900,1, 22636901,1, 22636902,1, 22636903,1, 22636904,1, 22636905,1, 22636906,1, 22636908,1, 22636909,1, 22636911,1, 22636912,1, 22636913,1, 22636914,1, 22636915,1, 22636916,1, 22636917,1, 22636918,1, 22636920,1, 22636921,1, 22636922,1, 22636923,1, 22636924,1, 22636925,1, 22636926,1, 22636927,1, 22636928,1, 22636929,1, 22636930,1, 22636932,1, 22636933,1, 22636934,1, 22636935,1, 22636936,1, 22636937,1, 22636938,1, 22636939,1, 22636940,1, 22636942,1, 22636943,1, 22636944,1, 22636945,1, 22636946,1, 22636947,1, 22636948,1, 22636950,1, 22636951,1, 22636952,1, 22636953,1, 22636954,1, 22636955,1, 22636956,1, 22636957,1, 22636958,1, 22636959,1, 22636962,1, 22636963,1, 22636964,1, 22636965,1, 22636966,1, 22636967,1, 22636968,1, 22636970,1, 22636971
      ,1, 22636972,1, 22636973,1, 22636974,1, 22636975,1, 22636977,1, 22636978,1, 22636979,1, 22636980,1, 22636981,1, 22636982,1, 22636983,1, 22636984,1, 22636985,1, 22636987,1, 22636988,1, 22636989,1, 22636990,1, 22636991,1, 22636992,1, 22636993,1, 22636994,1, 22636995,1, 22636997,1, 22636998,1, 22637000,1, 22637001,1, 22637002,1, 22637003,1, 22637004,1, 22637005,1, 22637006,1, 22637007,1, 22637008,1, 22637009,1, 22637010,1, 22637011,1, 22637012,1, 22637014,1, 22637015,1, 22637016,1, 22637017,1, 22637018,1, 22637019,1, 22637020,1, 22637021,1, 22637022,1, 22637024,1, 22637026,1, 22637027,1, 22637028,1, 22637029,1, 22637030,1, 22637031,1, 22637032,1, 22637034,1, 22637035,1, 22637036,1, 22637037,1, 22637038,1, 22637039,1, 22637040,1, 22637041,1, 22637042,1, 22637043,1, 22637044,1, 22637046,1, 22637047,1, 22637048,1, 22637049,1, 22637050,1, 22637051,1, 22637052,1, 22637053,1, 22637054,1, 22637055,1, 22637056,1, 22637059,1, 22637060,1, 22637061,1, 22637062,1, 22637063,1, 22637064,1,
      22637065,1, 22637066,1, 22637067,1, 22637068,1, 22637069,1, 22637071,1, 22637072,1, 22637073,1, 22637074,1, 22637075,1, 22637076,1, 22637077,1, 22637078,1, 22637080,1, 22637081,1, 22637082,1, 22637083,1, 22637084,1, 22637085,1, 22637086,1, 22637087,1, 22637088,1, 22637089,1, 22637091,1, 22637092,1, 22637093,1, 22637094,1, 22637095,1, 22637096,1, 22637097,1, 22637098,1, 22637099,1, 22637100,1, 22637101,1, 22637102,1, 22637104,1, 22637105,1, 22637106,1, 22637107,1, 22637108,1, 22637109,1, 22637110,1, 22637111,1, 22637112,1, 22637114,1, 22637115,1, 22637116,1, 22637117,1, 22637118,1, 22637119,1, 22637120,1, 22637122,1, 22637123,1, 22637124,1, 22637125,1, 22637126,1, 22637127,1, 22637128,1, 22637129,1, 22637130,1, 22637132,1, 22637133,1, 22637134,1, 22637135,1, 22637136,1, 22637137,1, 22637138,1, 22637139,1, 22637140,1, 22637141,1, 22637142,1, 22637143,1, 22637144,1, 22637147,1, 22637148,1, 22637149,1, 22637150,1, 22637151,1, 22637152,1, 22637153,1, 22637154,1, 22637155,1, 22637156
      ,1, 22637157,1, 22637158,1, 22637160,1, 22637161,1, 22637162,1, 22637163,1, 22637164,1, 22637165,1, 22637166,1, 22637167,1, 22637168,1, 22637170,1, 22637171,1, 22637172,1, 22637174,1, 22637176,1, 22637177,1, 22637178,1, 22637179,1, 22637180,1, 22637182,1, 22637183,1, 22637185,1, 22637186,1, 22637187,1, 22637188,1, 22637189,1, 22637190,1, 22637191,1, 22637193,1, 22637194,1, 22637195,1, 22637196,1, 22637197,1, 22637198,1, 22637199,1, 22637201,1, 22637203,1, 22637204,1, 22637205,1, 22637206,1, 22637207,1, 22637208,1, 22637209,1, 22637210,1, 22637211,1, 22637212,1, 22637214,1, 22637215,1, 22637216,1, 22637217,1, 22637218,1, 22637219,1, 22637220,1, 22637221,1, 22637223,1, 22637224,1, 22637225,1, 22637226,1, 22637227,1, 22637228,1, 22637230,1, 22637231,1, 22637232,1, 22637233,1, 22637235,1, 22637236,1, 22637237,1, 22637238,1, 22637239,1, 22637240,1, 22637241,1, 22637242,1, 22637243,1, 22637245,1, 22637246,1, 22637247,1, 22637248,1, 22637249,1, 22637250,1, 22637251,1, 22637252,1,
      22637253,1, 22637254,1, 22637256,1, 22637257,1, 22637258,1, 22637259,1, 22637260,1, 22637261,1, 22637262,1, 22637263,1, 22637265,1, 22637266,1, 22637267,1, 22637268,1, 22637269,1, 22637270,1, 22637271,1, 22637272,1, 22637273,1, 22637275,1, 22637276,1, 22637277,1, 22637278,1, 22637279,1, 22637280,1, 22637281,1, 22637283,1, 22637284,1, 22637285,1, 22637286,1, 22637287,1, 22637288,1, 22637289,1, 22637290,1, 22637292,1, 22637293,1, 22651527,1, 22651528,1, 22651530,1, 22651531,1, 22651532,1, 22651533,1, 22651534,1, 22651535,1, 22651536,1, 22651537,1, 22651538,1, 22651539,1, 22651553,1, 22651554,1, 22651558,1, 22651561,1, 22651562,1, 22651563,1, 22651564,1, 22651565,1, 22651566,1, 22651567,1, 22651568,1, 22651569,1, 22651570,1, 22651571,1, 22651572,1, 22651573,1, 22651574,1, 22651575,1, 22651576,1, 22651577,1, 22651578,1, 22651579,1, 22651580,1, 22651581,1, 22651582,1, 22651583,1, 22651584,1, 22651585,1, 22651586,1, 22651587,1, 22651588,1, 22651589,1, 22651590,1, 22651591,1, 22651592
      ,1, 22651593,1, 22651594,1, 22651595,1, 22651596,1, 22651597,1, 22651598,1, 22651599,1, 22651600,1, 22651601,1, 22651602,1, 22651605,1, 22651607,1, 22651608,1, 22651609,1, 22651612,1, 22651613,1, 22651614,1, 22651615,1, 22651616,1, 22651617,1, 22651618,1, 22651619,1, 22651620,1, 22651621,1, 22651622,1, 22651623,1, 22651624,1, 22651626,1, 22651627,1, 22651628,1, 22651629,1, 22651630,1, 22651631,1, 22651632,1, 22651633,1, 22651634,1, 22651635,1, 22651636,1, 22651638,1, 22651639,1, 22651640,1, 22651642,1, 22651643,1, 22651644,1, 22651645,1, 22651646,1, 22651647,1, 22651648,1, 22651650,1, 22651651,1, 22651653,1, 22651655,1, 22651656,1, 22651657,1, 22651658,1, 22651660,1, 22651661,1, 22651662,1, 22651663,1, 22651664,1, 22651666,1, 22651667,1, 22651668,1, 22651670,1, 22651671,1, 22651672,1, 22651673,1, 22651674,1, 22651675,1, 22651676,1, 22651677,1, 22651680,1, 22651681,1, 22651682,1, 22651683,1, 22651684,1, 22651686,1, 22651689,1, 22651690,1, 22651691,1, 22651699,1, 22651700,1,
      22651701,1, 22651702,1, 22651703,1, 22651705,1, 22651706,1, 22651708,1, 22651709,1, 22651710,1, 22651711,1, 22651712,1, 22651714,1, 22651715,1, 22651717,1, 22651718,1, 22651724,1, 22651725,1, 22651726,1, 22651727,1, 22651729,1, 22651730,1, 22651731,1, 22651736,1, 22651738,1, 22651739,1, 22651740,1, 22651741,1, 22651743,1, 22651745,1, 22651746,1, 22651747,1, 22651748,1, 22651749,1, 22651751,1, 22651753,1, 22651754,1, 22651755,1, 22651756,1, 22651757,1, 22651758,1, 22651759,1, 22651760,1, 22651761,1, 22651762,1, 22651763,1, 22651764,1, 22651765,1, 22651766,1, 22651767,1, 22651768,1, 22651770,1, 22651772,1, 22651773,1, 22651774,1, 22651776,1, 22651777,1, 22651778,1, 22651779,1, 22651780,1, 22651781,1, 22651782,1, 22651783,1, 22651784,1, 22651786,1, 22651788,1, 22651789,1, 22651790,1, 22651792,1, 22651793,1, 22651794,1, 22651795,1, 22651796,1, 22651797,1, 22651798,1, 22651799,1, 22651801,1, 22651802,1, 22651803,1, 22651804,1, 22651805,1, 22651806,1, 22651807,1, 22651808,1, 22651810
      ,1, 22651811,1, 22651812,1, 22651813,1, 22651814,1, 22651815,1, 22651816,1, 22651817,1, 22651818,1, 22651819,1, 22651821,1, 22651823,1, 22651824,1, 22651825,1, 22651826,1, 22651827,1, 22651828,1, 22651829,1, 22651830,1, 22651831,1, 22651832,1, 22651833,1, 22651834,1, 22651836,1, 22651837,1, 22651838,1, 22651839,1, 22651840,1, 22651841,1, 22651843,1, 22651844,1, 22651845,1, 22651846,1, 22651847,1, 22651848,1, 22651850,1, 22651851,1, 22651852,1, 22651853,1, 22651854,1, 22651855,1, 22651856,1, 22651857,1, 22651859,1, 22651860,1, 22651861,1, 22651862,1, 22651863,1, 22651864,1, 22651866,1, 22651867,1, 22651868,1, 22651869,1, 22651870,1, 22651872,1, 22651873,1, 22651874,1, 22651875,1, 22651877,1, 22651878,1, 22651879,1, 22651880,1, 22651881,1, 22651882,1, 22651883,1, 22651884,1, 22651886,1, 22651887,1, 22651888,1, 22651889,1, 22651890,1, 22651891,1, 22651892,1, 22651894,1, 22651895,1, 22651896,1, 22651897,1, 22651898,1, 22651899,1, 22651900,1, 22651901,1, 22651902,1, 22651903,1,
      22651905,1, 22651906,1, 22651907,1, 22651908,1, 22651909,1, 22651911,1, 22651912,1, 22651913,1, 22651914,1, 22651915,1, 22651916,1, 22651917,1, 22651919,1, 22651920,1, 22651921,1, 22651922,1, 22651923,1, 22651924,1, 22651947,1, 22651948,1, 22651949,1, 22651951,1, 22651952,1, 22651953,1, 22651954,1, 22651955,1, 22651956,1, 22651957,1, 22651959,1, 22651960,1, 22651961,1, 22651962,1, 22651963,1, 22651965,1, 22651966,1, 22651967,1, 22651968,1, 22651969,1, 22651970,1, 22651971,1, 22651972,1, 22651974,1, 22651975,1, 22651977,1, 22651980,1, 22651981,1, 22651982,1, 22651983,1, 22651984,1, 22651985,1, 22651987,1, 22651988,1, 22651989,1, 22651990,1, 22651991,1, 22651992,1, 22651993,1, 22651995,1, 22651996,1, 22651997,1, 22651998,1, 22651999,1, 22652001,1, 22652002,1, 22652003,1, 22652004,1, 22652005,1, 22652006,1, 22652007,1, 22652008,1, 22652010,1, 22652011,1, 22652013,1, 22652014,1, 22652016,1, 22652017,1, 22652018,1, 22652019,1, 22652020,1, 22652021,1, 22652022,1, 22652024,1, 22652025
      ,1, 22652026,1, 22652027,1, 22652028,1, 22652029,1, 22652030,1, 22652031,1, 22652033,1, 22652034,1, 22652035,1, 22652036,1, 22652037,1, 22652039,1, 22652040,1, 22652041,1, 22652042,1, 22652043,1, 22652045,1, 22652046,1, 22652047,1, 22652049,1, 22652050,1, 22652051,1, 22652054,1, 22652055,1, 22652057,1, 22652058,1, 22652059,1, 22652060,1, 22652061,1, 22652062,1, 22652063,1, 22652064,1, 22652065,1, 22652066,1, 22652067,1, 22652069,1, 22652070,1, 22652071,1, 22652072,1, 22652073,1, 22652074,1, 22652075,1, 22652076,1, 22652077,1, 22652079,1, 22652080,1, 22652081,1, 22652082,1, 22652083,1, 22652084,1, 22652085,1, 22652086,1, 22652087,1, 22652088,1, 22652090,1, 22652091,1, 22652092,1, 22652093,1, 22652094,1, 22652095,1, 22652096,1, 22652097,1, 22652098,1, 22652099,1, 22652100,1, 22652102,1, 22652103,1, 22652104,1, 22652105,1, 22652106,1, 22652107,1, 22652108,1, 22652109,1, 22652111,1, 22652112,1, 22652113,1, 22652115,1, 22652116,1, 22652117,1, 22652118,1, 22652119,1, 22652122,1,
      22652123,1, 22652124,1, 22652125,1, 22652126,1, 22652128,1, 22652129,1, 22652130,1, 22652132,1, 22652133,1, 22652135,1, 22652137,1, 22652138,1, 22652139,1, 22652140,1, 22652141,1, 22652143,1, 22652144,1, 22652145,1, 22652146,1, 22652147,1, 22652148,1, 22652149,1, 22652150,1, 22652152,1, 22652153,1, 22652154,1, 22652155,1, 22652156,1, 22652157,1, 22652158,1, 22652159,1, 22652160,1, 22652162,1, 22652163,1, 22652164,1, 22652165,1, 22652167,1, 22652168,1, 22652169,1, 22652170,1, 22652171,1, 22652172,1, 22652174,1, 22652175,1, 22652176,1, 22652177,1, 22652178,1, 22652179,1, 22652180,1, 22652181,1, 22652182,1, 22652183,1, 22652185,1, 22652186,1, 22652187,1, 22652188,1, 22652189,1, 22652190,1, 22652192,1, 22652193,1, 22652194,1, 22652195,1, 22652196,1, 22652197,1, 22652198,1, 22652200,1, 22652201,1, 22652202,1, 22652203,1, 22652204,1, 22652205,1, 22652206,1, 22652207,1, 22652208,1, 22652209,1, 22652210,1, 22652212,1, 22652213,1, 22652214,1, 22652216,1, 22652217,1, 22652218,1, 22652219
      ,1, 22652220,1, 22652221,1, 22652223,1, 22652224,1, 22652225,1, 22652226,1, 22652227,1, 22652228,1, 22652229,1, 22652231,1, 22652232,1, 22652233,1, 22652234,1, 22652235,1, 22652236,1, 22652237,1, 22652238,1, 22652239,1, 22652240,1, 22652241,1, 22652242,1, 22652243,1, 22652244,1, 22652245,1, 22652246,1, 22652247,1, 22652249,1, 22652250,1, 22652251,1, 22652252,1, 22652253,1, 22652254,1, 22652255,1, 22652256,1, 22652257,1, 22652258,1, 22652259,1, 22652260,1, 22652261,1, 22652262,1, 22652263,1, 22652264,1, 22652265,1, 22652266,1, 22652267,1, 22652268,1, 22652269,1, 22652271,1, 22652272,1, 22652273,1, 22652274,1, 22652275,1, 22652276,1, 22652277,1, 22652279,1, 22652280,1, 22652281,1, 22652282,1, 22652283,1, 22652284,1, 22652286,1, 22652287,1, 22652288,1, 22652290,1, 22652291,1, 22652292,1, 22652293,1, 22652295,1, 22652296,1, 22652297,1, 22652298,1, 22652299,1, 22652300,1, 22652301,1, 22652303,1, 22652304,1, 22652305,1, 22652306,1, 22652307,1, 22652309,1, 22652310,1, 22652311,1,
      22652312,1, 22652313,1, 22652315,1, 22652316,1, 22652317,1, 22652318,1, 22652319,1, 22652320,1, 22652322,1, 22652323,1, 22652324,1, 22652325,1, 22652326,1, 22652328,1, 22652329,1, 22652330,1, 22652331,1, 22652332,1, 22652333,1, 22652334,1, 22652335,1, 22652337,1, 22652338,1, 22652339,1, 22652340,1, 22652341,1, 22652343,1, 22652344,1, 22652345,1, 22652346,1, 22652347,1, 22652348,1, 22652350,1, 22652351,1, 22652352,1, 22652353,1, 22652354,1, 22652355,1, 22652356,1, 22652358,1, 22652359,1, 22652360,1, 22652361,1, 22652362,1, 22652363,1, 22652364,1, 22652365,1, 22652367,1, 22652368,1, 22652369,1, 22652370,1, 22652371,1, 22652372,1, 22652373,1, 22652374,1, 22652375,1, 22652376,1, 22652377,1, 22652378,1, 22652380,1, 22652381,1, 22652382,1, 22652383,1, 22652384,1, 22652385,1, 22652386,1, 22652388,1, 22652389,1, 22652390,1, 22652391,1, 22652392,1, 22652394,1, 22652395,1, 22652396,1, 22652397,1, 22652399,1, 22652400,1, 22652401,1, 22652402,1, 22652403,1, 22652404,1, 22652405,1, 22652406
      ,1, 22652407,1, 22652408,1, 22652410,1, 22652411,1, 22652412,1, 22652413,1, 22652414,1, 22652415,1, 22652416,1, 22652417,1, 22652418,1, 22652420,1, 22652421,1, 22652423,1, 22652424,1, 22652425,1, 22652426,1, 22652427,1, 22652429,1, 22652430,1, 22652432,1, 22652433,1, 22652434,1, 22652435,1, 22652436,1, 22652438,1, 22652439,1, 22652440,1, 22652441,1, 22652442,1, 22652443,1, 22652444,1, 22652445,1, 22652446,1, 22652447,1, 22652449,1, 22652450,1, 22652451,1, 22652452,1, 22652453,1, 22652454,1, 22652456,1, 22652457,1, 22652458,1, 22652459,1, 22652460,1, 22652462,1, 22652463,1, 22652464,1, 22652465,1, 22652466,1, 22652467,1, 22652468,1, 22652469,1, 22652471,1, 22652472,1, 22652473,1, 22652474,1, 22652476,1, 22652477,1, 22652478,1, 22652479,1, 22652480,1, 22652481,1, 22652483,1, 22652484,1, 22652485,1, 22652486,1, 22652487,1, 22652488,1, 22652490,1, 22652491,1, 22652492,1, 22652493,1, 22652494,1, 22652495,1, 22652496,1, 22652497,1, 22652498,1, 22652500,1, 22652501,1, 22652502,1,
      22652503,1, 22652504,1, 22652505,1, 22652506,1, 22652507,1, 22652508,1, 22652509,1, 22652510,1, 22652512,1, 22652513,1, 22652514,1, 22652515,1, 22652516,1, 22652517,1, 22652518,1, 22652519,1, 22652521,1, 22652523,1, 22652524,1, 22652526,1, 22652527,1, 22652528,1, 22652529,1, 22652530,1, 22652534,1, 22652535,1, 22652536,1, 22652537,1, 22652538,1, 22652539,1, 22652540,1, 22654525,1, 22654526,1, 22654527,1, 22654528,1, 22654529,1, 22654530,1, 22654531,1, 22654532,1, 22654534,1, 22654535,1, 22654536,1, 22654537,1, 22654538,1, 22654540,1, 22654541,1, 22654542,1, 22654543,1, 22654544,1, 22654545,1, 22654547,1, 22654548,1, 22654549,1, 22654550,1, 22654551,1, 22654552,1, 22654553,1, 22654554,1, 22654556,1, 22654557,1, 22654558,1, 22654559,1, 22654560,1, 22654561,1, 22654562,1, 22654563,1, 22654564,1, 22654566,1, 22654567,1, 22654568,1, 22654569,1, 22654570,1, 22654571,1, 22654572,1, 22654573,1, 22654574,1, 22654575,1, 22654577,1, 22654578,1, 22654579,1, 22654580,1, 22654581,1, 22654582
      ,1, 22654584,1, 22654585,1, 22654586,1, 22654587,1, 22654588,1, 22654589,1, 22654591,1, 22654592,1, 22654594,1, 22654595,1, 22654596,1, 22654598,1, 22654600,1, 22654601,1, 22654602,1, 22654603,1, 22654604,1, 22654605,1, 22654606,1, 22654607,1, 22654608,1, 22654610,1, 22654611,1, 22654612,1, 22654613,1, 22654614,1, 22654615,1, 22654616,1, 22654617,1, 22654618,1, 22654620,1, 22654622,1, 22654623,1, 22654624,1, 22654625,1, 22654627,1, 22654628,1, 22654629,1, 22654630,1, 22654631,1, 22654632,1, 22654633,1, 22654635,1, 22654636,1, 22654637,1, 22654638,1, 22654639,1, 22654641,1, 22654642,1, 22654643,1, 22654644,1, 22654645,1, 22654646,1, 22654648,1, 22654649,1, 22654651,1, 22654652,1, 22654653,1, 22654654,1, 22654655,1, 22654656,1, 22654657,1, 22654658,1, 22654659,1, 22654660,1, 22654661,1, 22654663,1, 22654664,1, 22654665,1, 22654666,1, 22654667,1, 22654668,1, 22654669,1, 22654670,1, 22654671,1, 22654673,1, 22654674,1, 22654675,1, 22654676,1, 22654677,1, 22654678,1, 22654694,1,
      22654695,1, 22654696,1, 22654697,1, 22654698,1, 22654699,1, 22654700,1, 22654701,1, 22654702,1, 22654703,1, 22654705,1, 22654706,1, 22654707,1, 22654708,1, 22654709,1, 22654710,1, 22654711,1, 22654712,1, 22654713,1, 22654715,1, 22654716,1, 22654717,1, 22654718,1, 22654719,1, 22654721,1, 22654722,1, 22654723,1, 22654726,1, 22654728,1, 22654729,1, 22654730,1, 22654731,1, 22654733,1, 22654734,1, 22654735,1, 22654736,1, 22654737,1, 22654738,1, 22654739,1, 22654740,1, 22654741,1, 22654742,1, 22654744,1, 22654745,1, 22654746,1, 22654747,1, 22654748,1, 22654749,1, 22654750,1, 22654751,1, 22654752,1, 22654754,1, 22654755,1, 22654756,1, 22654757,1, 22654758,1, 22654759,1, 22654760,1, 22654761,1, 22654762,1, 22654763,1, 22654764,1, 22654766,1, 22654767,1, 22654768,1, 22654769,1, 22654770,1, 22654771,1, 22654772,1, 22654774,1, 22654775,1, 22654776,1, 22654777,1, 22654778,1, 22654779,1, 22654780,1, 22654781,1, 22654783,1, 22654784,1, 22654785,1, 22654786,1, 22654787,1, 22654788,1, 22654789
      ,1, 22654790,1, 22654792,1, 22654793,1, 22654794,1, 22654795,1, 22654796,1, 22654797,1, 22654798,1, 22654799,1, 22654801,1, 22654802,1, 22654803,1, 22654804,1, 22654805,1, 22654806,1, 22654807,1, 22654808,1, 22654809,1, 22654810,1, 22654811,1, 22654813,1, 22654814,1, 22654815,1, 22654816,1, 22654817,1, 22654818,1, 22654819,1, 22654821,1, 22654822,1, 22654823,1, 22654824,1, 22654825,1, 22654826,1, 22654827,1, 22654828,1, 22654829,1, 22654830,1, 22654831,1, 22654832,1, 22654835,1, 22654836,1, 22654837,1, 22654838,1, 22654839,1, 22654841,1, 22654842,1, 22654844,1, 22654845,1, 22654846,1, 22654848,1, 22654849,1, 22654850,1, 22654851,1, 22654852,1, 22654853,1, 22654855,1, 22654856,1, 22654857,1, 22654858,1, 22654859,1, 22654861,1, 22654862,1, 22654863,1, 22654864,1, 22654865,1, 22654867,1, 22654868,1, 22654869,1, 22654870,1, 22654871,1, 22654872,1, 22654873,1, 22654874,1, 22654877,1, 22654878,1, 22654880,1, 22654881,1, 22654883,1, 22654885,1, 22654888,1, 22654889,1, 22654890,1,
      22654891,1, 22654892,1, 22654893,1, 22654905,1, 22654906,1, 22654907,1, 22654908,1, 22654910,1, 22654911,1, 22654912,1, 22654914,1, 22654918,1, 22654920,1, 22654921,1, 22654922,1, 22654924,1, 22654925,1, 22654927,1, 22654928,1, 22654929,1, 22654930,1, 22654932,1, 22654933,1, 22654935,1, 22654937,1, 22654939,1, 22654940,1, 22654942,1, 22654943,1, 22654945,1, 22654946,1, 22654948,1, 22654950,1, 22654951,1, 22654952,1, 22654954,1, 22654956,1, 22654957,1, 22654958,1, 22654960,1, 22654961,1, 22654963,1, 22654964,1, 22654965,1, 22654967,1, 22654969,1, 22654970,1, 22654972,1, 22654973,1, 22654974,1, 22654975,1, 22654976,1, 22654978,1, 22654980,1, 22654981,1, 22654982,1, 22654983,1, 22654984,1, 22654987,1, 22654988,1, 22654989,1, 22654990,1, 22654991,1, 22654993,1, 22654995,1, 22667529,1, 22667542,1, 22667545,1, 22667548,1, 22667550,1, 22667551,1, 22667552,1, 22667553,1, 22667554,1, 22667555,1, 22667556,1, 22667557,1, 22667558,1, 22667561,1, 22667562,1, 22667563,1, 22667564,1, 22667565
      ,1, 22667567,1, 22667571,1, 22667573,1, 22667575,1, 22667577,1, 22667579,1, 22667581,1, 22667584,1, 22667585,1, 22667590,1, 22667592,1, 22667594,1, 22667595,1, 22667597,1, 22667603,1, 22667604,1, 22667607,1, 22667612,1, 22667615,1, 22667627,1, 22667628,1, 22667632,1, 22667636,1, 22667638,1, 22667639,1, 22667640,1, 22667642,1, 22667643,1, 22668526,1, 22668529,1, 22669526,1, 22670526,1, 22670527,1, 22670530,1, 22670533,1, 22670534,1, 22670536,1, 22670537,1, 22670539,1, 22670540,1, 22670541,1, 22670542,1, 22670543,1, 22670544,1, 22670545,1, 22670546,1) =1;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Process Start Date'|| Sysdate);
  fnd_global.APPS_INITIALIZE(user_id=>1191, RESP_ID=>51241, resp_appl_id=>879);
  FOR REC_ORG_NUMBER IN CUR_ORG_NUMBER
  LOOP
    V_ORG_NAME:=REC_ORG_NUMBER.JGZZ_FISCAL_CODE;
    -- LV_STAGE := 'In parameters p_org_no:'||REC_ORG_NUMBER.JGZZ_FISCAL_CODE||' p_duns_number:'||REC_ORG_NUMBER.DUNS_NUMBER||' p_country:'||REC_ORG_NUMBER.COUNTRY||' p_source:'||'AD_HOC';
    -- DBMS_OUTPUT.PUT_LINE('Record processing '|| LV_STAGE);
    BEGIN
      SELECT party_id
      INTO l_party_id
      FROM HZ_PARTIES hp
      WHERE jgzz_fiscal_code = REC_ORG_NUMBER.JGZZ_FISCAL_CODE
      AND ATTRIBUTE17        = REC_ORG_NUMBER.ATTRIBUTE17
      AND status             ='A'
      AND created_by_module IN
        (SELECT lookup_code
        FROM FND_LOOKUP_VALUES
        WHERE lookup_type='XXCU_BIS_REF_CREATE_MOD_LKP'
        AND enabled_flag ='Y'
        )
      AND NOT EXISTS
        (SELECT 1 FROM ap_suppliers apsup WHERE apsup.party_id = hp.party_id
        )
      AND NOT EXISTS
        (SELECT 1
        FROM HZ_CODE_ASSIGNMENTS
        WHERE OWNER_TABLE_NAME='HZ_PARTIES'
        AND class_code       IN ('BANK', 'CLEARINGHOUSE','BANK_BRANCH')
        AND class_category   IN ( 'BANK_INSTITUTION_TYPE','BANK_BRANCH_TYPE')
        AND owner_table_id    = hp.PARTY_ID
        )
      AND NOT EXISTS
        (SELECT 1
        FROM HZ_parties
        WHERE PARTY_TYPE='ORGANIZATION'
        AND (created_by_module LIKE 'FUN_AGIS'
        OR created_by_module LIKE 'XLE_CREATE_LE')
        AND party_id=hp.PARTY_ID
        );
      ------Condition addition end for 8373
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      LV_STAGE := 'Party does not exists in the system '||REC_ORG_NUMBER.JGZZ_FISCAL_CODE;
      DBMS_OUTPUT.PUT_LINE('ERROR:'|| LV_STAGE);
    WHEN OTHERS THEN
      LV_STAGE := 'Error while checking party '||REC_ORG_NUMBER.JGZZ_FISCAL_CODE||SQLERRM;
      DBMS_OUTPUT.PUT_LINE('ERROR:'|| LV_STAGE);
    END;
    BEGIN
      INSERT
      INTO XXCU.XXCU_credit_refresh_tbl
        (
          Orgno,
          Country,
          Duns_number,
          source,
          Party_id,
          search_status,
          upd_status,
          refresh_status,
          creation_date
        )
        VALUES
        (
          REC_ORG_NUMBER.JGZZ_FISCAL_CODE,
          REC_ORG_NUMBER.ATTRIBUTE17,
          REC_ORG_NUMBER.DUNS_NUMBER,
          'AD_HOC',
          l_party_id,
          'NEW',
          'NEW',
          'NEW',
          sysdate
        );
    EXCEPTION
    WHEN OTHERS THEN
      LV_STAGE := 'Error while fetching party id '||REC_ORG_NUMBER.JGZZ_FISCAL_CODE||SQLERRM;
      DBMS_OUTPUT.PUT_LINE('ERROR:'|| LV_STAGE);
      UPDATE XXCU_TEST_ORG_NUMBER
      SET CREATION_DATE = SYSDATE,
        STATUS          = 'ERROR',
        ERROR_MESSAGE   =SUBSTR(LV_STAGE, 0,250)
      WHERE ORG_NUMBER  = REC_ORG_NUMBER.JGZZ_FISCAL_CODE;
    END;
    BEGIN
      UPDATE XXCU_TEST_ORG_NUMBER
      SET STATUS       = 'PROCESSED',
        CREATION_DATE  = SYSDATE
      WHERE ORG_NUMBER = REC_ORG_NUMBER.JGZZ_FISCAL_CODE;
      COMMIT;
    EXCEPTION
    WHEN OTHERS THEN
      LV_STAGE := 'Error while pdating custom table '||REC_ORG_NUMBER.JGZZ_FISCAL_CODE||SQLERRM;
      DBMS_OUTPUT.PUT_LINE('ERROR:'|| LV_STAGE);
    END;
  END LOOP;
  XXCU_CREDIT_REFRESH_PKG.CUSTOMER_REFRESH(X_CRE_MSG,X_CRE_RET,NULL);
  DBMS_OUTPUT.PUT_LINE('Process End Date'|| Sysdate);
EXCEPTION
WHEN OTHERS THEN
  LV_STAGE := 'Error while pdating out block '||V_ORG_NAME||SQLERRM;
  UPDATE XXCU_TEST_ORG_NUMBER
  SET CREATION_DATE = SYSDATE,
    STATUS          = 'ERROR',
    ERROR_MESSAGE   =SUBSTR(LV_STAGE, 0,250)
  WHERE ORG_NUMBER  = V_ORG_NAME;
  COMMIT;
END;
/