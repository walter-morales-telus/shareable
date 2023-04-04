/**** NO NO NO OPTIK TV Tax Included Offer NO NO NO ****/
DECLARE
    cnt NUMBER := 0;
    v_code  NUMBER;
    v_errm  VARCHAR2(64);
    apc          NUMBER;
    old_tax_code NUMBER;

    TYPE NumberArrayType IS TABLE of NUMBER;
    NumArray NumberArrayType := NumberArrayType 
    (
        9152222266513216902,9152222267013216906,9152222267013216910,9152222267013216914,9152222267013216918,9152222267113216942,9152222267113216946,9152222267113216950,
        9152222267113216954,9152222267113216958,9152222267113216962,9152222267113216966,9152222267113216970,9152222267113216974,9152222267113216978,9163573325904744482,
        9163642091140824412,9164793039242235072,9164740067049234863,9166046418602507086,9163693615428824541,9165890438542777598,9166054674435079626,9153917903813349202,
        9165741847091038130,9160675422213633905,9160675273713633376,9165717650633038105,9164800303681882392,9161299922839665397,9161299928737665398,9154283781913031958,
        9152800240613765059,9156303605313190930,9165880528097777325,9165880572256777327,9165880414256162910,9155711180913950590,9165880489831777323,9162484784853804579,
        9162484770396380083,9155410044813141825,9155409449713141392,9162484767726380080,9155409889413141715,9161224004613222775,9155409633113141499,9162484786136804580,
        9155409879413141710,9162484765768380079,9155410057813141830,9162485610282737048,9162166160773176493,9162166219397524032,9162166278477524033,9162166358734604418,
        9162171155487176498,9162171006152176497,9162170888545524038,9152222267013216922,9152222267013216926,9152222267113216930,9152222267113216934,9152222267113216938,
        9162128406697523965,9162170792835604419,9162171215088604421,9162171636430176500,9162172139353604423,9162172161122176501,9162173149865604424,9162173155860524040,
        9162182663638524066,9162317870771320348,9162182960064176506,9162183177556604459,9162232340719639223,9162232370241637123,9162232604602637124,9162232782137639224,
        9162232816891637125,9152222433213217110,9152222433213217114,9153469766013287661,9153469849413287671,9153470399813288002,9153470564813288022,9153469723413287656,
        9153469804413287666,9153470324313287892,9153470532213288017,9156379487513076196,9156379764213076547,9159033666113378903,9159033882713379042,9159034013313379155,
        9150995295613501798,9151228215313652321,9160749291613917445,9166079616961507164,9162796246682662086,9163410821067963319,9163030331266415131,9163030499396653779,
        9164433639893595590,9164957603973320280,9164775176394855277,9164775677653693267,9161940653197782379,9162607584202256040,9162848222183813621,9165811159979039244,
        9164602790034317396,9165880116827162896,9163262016790813470,9163262088736648824,9163270797922059643,9163402281095963296,9163402281201963299,9163462538794819413,
        9163808321697015472,9163237254127648806,9166190843202039308,9159829207813575709,9163348252863699876,9163418075010203788,9165716158948130356,9161171393313681619,
        9165145479676304019,9161940775008976769,9162615558349256054,9164602806206174751,9165880137343777315,9163348207296699870,9166190790327507461,9163451617358819378,
        9163417900221137086,9163445038385709609,9165716158234130354,9165145602473891497,9161171432913738091,9162615511038739404,9163175430379812996,9163177787581646770,
        9165467132087921648,9163221187494625448,9163687424489645218,9163687966843645232,9163688061908645244,9163694215164645259,9163694291539622574,9163694452526824567,
        9163694641115645269,9163807344385232903,9163807447388015450,9163807497639970831,9163807601461232920,9163807674986970851,9163807737435232935,9163530483411203292,
        9162683653854158039,9162720101531155133,9162683676955158045,9162720037043786416,9164775724968235000,9164775821577235006,9165716158635038102,9164921245828890985,
        9164921610078890988,9164930482164320263,9164775776563693271,9164783275123235045,9164775845837693278,9164783314256855337,9164362304922967455,9164362361837181068,
        9163581772599231197,9163590958994744531,9162752730656155379,9159477479113115937,9159591399413748656,9159832790513019843,9165778386864131332,9165803474180131341,
        9165812316010985770,9165813677296039249,9162796105717685268,9164722552392653940,9165862559146039352,9163107787077578053,9163988515292886697,9164369984518181084,
        9164567972042675101,9164620325088317553,9164721614932777710,9164793065004693349,9165138368382891461,9165232452008055344,9165873015774039456,9166045529087038925,
        9166114629161039076,9163418785586203795,9163418785833203798,9163462567385807055,9166046450115079606,9163175368285625217,9163228488247813432,9163270943766059647,
        9164324940784180978,9164325826116967384,9164360046737967443,9165637665195921844,9165681862648921943,9163816686384015476,9166104307832039043,9159823307213567862,
        9159993754213042753,9159993789213044857,9163505371082201663,9163583252609231206,9163583299164231209,9163583299246231212,9163600763297744543,9163600793546187559,
        9163600793896187562,9164982564268303581,9156192893413938014,9162969962544409568,9162969962595409567,9163771656745970764,9163781665357970783,9164391584860492552,
        9164477618598151102,9165083914976320657,9163504726156807892,9163504775950201654,9163504887965201657,9164875464865407746,9153532200913330825,9153524866313325616,
        9161212296913214987,9162532466750187436,9153525772313326376,9161212499413215100,9162537215783187443,9153532270213330950,9153524378413320974,9158679528613046709,
        9156315709513090872,9156315715713090877,9157248770313218607,9160563092413315497,9158634870713145802,9155280244013041804,9156290391713061578,9155280244213041809,
        9155280244413041814,9164429210252923534,9164437426730923555,9163283967813870394,9163929252676886613,9163391732081709445,9163443598757709596,9163875886969970918,
        9163953676705690029,9164739673920693085,9164421569528732407,9164388130406181115,9164412658495317715,9164411344461317693,9164750775440693196,9164420300312595485,
        9164479990385685637,9164724441074653954,9164420019025595483,9164480401995685640,9164963928090303503,9164861402627650172,9164861997070650177,9164862017861457497,
        9164961820929320287,9164904688403650288,9164972432170320361,9164978064870320380,9165217453813330323,9165217403677330321,9164904642848457602,9164860583340650167,
        9165318207909055497,9164974640186303555,9164991803634891167,9163330446961707838,9164797656811258485,9163160815070325007,9163160944936084760,9158863837713668063,
        9155681459213186902,9165036005852320579,9163818020212232961,9163818706669970874,9164158215131562886,9164178632913446967,9164179066379450648,9165450091858055829,
        9165051637220320604,9162900263628724592,9162918871413281908,9162884629880724038,9162884655172226824,9165051603973891302,9165015710704320474,9164991515065891158,
        9165015645452320470,9160728892313905870,9166177048402507421,9166177068099039250,9166177005146079975,9166177027926079976,9155410024213141720,9155409697713141504,
        9162796320219108568,9163654406802622440,9163654413514622442,9163654428891622443,9163654422164645153,9163654371974622435,9163654361015622434,9163654347053645150,
        9163654326525622432,9163654390420622437,9163654398377622438,9164843929315407627,9164793046616693347,9164792985719693342,9164792993283693344,9159599900313819982,
        9159600003913820318,9159600232713820866,9159600431413822869,9159606108013847142,9160005336613179509,9160005338613179643,9160005339513179712,9160005340313179833,
        9160131976913290402,9160132066213290505,9160132136213290662,9164719321427619760,9164797531552882379,9164798898776882388,9164776245729235015,9159598116113792125,
        9159598242013794592,9159599900113819954,9159600003913820346,9159600232613820838,9159600431413822897,9159606108013847068,9160131828513290211,9160131976913290359,
        9160132066213290509,9160132136213290724,9164775623582855279,9164777176642235035,9165033928230303755,9159598116113792079,9159598242213794784,9159600003913820374,
        9159606107713847040,9160005338613179617,9160005340313179820,9160005341013179867,9160131828513290228,9160131976913290427,9160132136213290712,9162860975488813664,
        9164432620584732480,9164776545159693290,9164779191503855321,9164799028715279251,9165043900584320588,9164782618281693310,9159820245013566425,9155858551613926361,
        9164909596899457622,9155856897013923176,9159350119513208151,9159350119713208156,9159633598313566669,9159350067213208141,9159350119313208146,9159633598113566664,
        9159350119913208161,9159350120013208166,9159633598513566674,9165206395144376902,9165207174095376903,9165139619782891477,9160255773613239115,9163107318390081978,
        9165035962441320577,9164784723227855382,9164801664024279278,9164851736748457443,9164862633707457500,9165043360595320581,9165051495223891295,9160555335613311504,
        9160555403413311510,9160555547213311616,9156315694313090867,9154829195413214729,9154829860713215107,9154829926113215117,9154830089313215232,9155882804513436700,
        9154829117313214724,9154829209813214734,9154829887013215112,9154830055313215227,9155583252913200702,9155584490513201837,9155584511113202036,9155591508113210002,
        9155882804513436704,9155952154013995060,9156100635613171246,9155952154013994972,9165087575495303885,9149675144813097567,9150082841513470087,9150082848713470092,
        9150165500913181620,9150227659313137817,9150227866413137993,9150227877513138002,9150227883913138007,9150227883913138011,9150227889713138016,9150227889713138020,
        9150227889713138024,9150227889713138028,9150227889713138032,9150227889713138036,9150468568413165504,9150468754513165619,9150468943113165639,9150469133413165754,
        9150479623613177972,9150491012613183215,9150491034113183220,9150491046313183225,9150491055013183230,9150491066413183235,9150491077213183240,9150491086213183245,
        9150491096813183250,9150491107113183255,9150491118513183260,9150491129613183365,9150491138413183370,9150491146713183375,9150491154213183380,9150491164613183385,
        9150491172313183390,9150491238613183400,9150491271013183411,9150580933913199592,9150580990513199600,9150581119713199618,9150581292513199743,9150581334713199753,
        9150581389013199858,9150581784513199970,9150597643213199682,9150629626113217808,9150653105313246285,9150653112913246426,9150657332513250114,9150657344113250169,
        9150691368113385763,9150691736113387321,9150691977513387846,9150691993913387863,9150692230013388123,9150692241213388248,9150692260713388263,9150692270113388278,
        9150692332013388417,9150692461313389333,9150692471913389341,9150748086413689543,9150842360913480364,9150859068113491881,9150883296713508923,9150996223813502684,
        9151471263213316402,9151471753213316802,9151472274113317503,9151480287013323518,9151480298413323625,9151498492713354034,9151523992613376292,9151524216413376939,
        9151524474913377334,9151524611613377439,9151531282113382044,9151541282413400861,9151548505413407139,9151593769113899385,9151594034613899495,9151738753613653330,
        9151738806913653639,9151739366613655139,9151739974213657509,9151782494813699877,9151849254213207399,9151858580313217994,9151919141413284905,9151954376413313672,
        9152093235813010834,9152094914213012139,9152210814813354579,9152502048513973847,9152561820613040560,9152562042813041039,9152638490713513558,9152697763513574134,
        9152698419413574839,9152703597113140323,9152703633413141082,9152757945113639918,9152758008513640110,9152915045213768365,9152915333713768731,9152940697513788739,
        9153008998513871068,9153009502513871564,9153034575113892614,9153034575613892700,9153034680013893317,9153035016713893540,9153035660513896123,9153035678213896209,
        9153256381613859539,9153256727113860055,9153415572813981276,9153415739413981476,9153491493313304153,9153523767213320525,9153552995313151400,9153553057413151725,
        9153585182213373605,9153619974913455374,9153639718313262535,9153822878313680473,9153956754713596339,9153974740713607366,9153983722513615436,9154252582813817741,
        9154252740113817951,9154253096113818497,9154253222013818609,9154268662113836259,9154331122213968764,9154425741913505336,9154560597613899734,9154561822413903113,
        9154763583313438524,9154764355113439902,9154807164113492135,9154815735013500435,9155352401713907494,9155531799513040843,9155583015813200112,9155583023113200343,
        9155584490213201708,9155584511013201948,9155606191313387846,9155607456013390714,9155711086513468230,9155711146713468681,9155726628413478631,9155726667913478783,
        9155728708613482189,9155761674813898224,9155777997513910803,9155882804513436545,9155945582613488440,9155952154013995038,9156100635613171218,9156255393813993030,
        9156297445013064914,9156299503913068903,9156373419813070841,9156377023113145624,9156379487413076108,9156379697613076255,9156379764113076459,9156392952813162014,
        9156401799313170822,9156557631913300414,9156631565013666830,9156631886013667044,9156632120913667268,9156632836713668087,9156687060213451655,9156703875013461914,
        9157576503113103562,9157585028413112522,9157593175613121214,9157594372113125586,9158022341013027055,9158022910713027447,9158024255213028883,9158024672213029229,
        9158205992313673855,9158364312313775776,9158364312313775781,9158364312313775804,9158665922613039085,9158675548313043709,9158678253413045099,9158678369213045136,
        9158678710413045471,9158678872313045735,9158679202013046006,9158679289613046268,9158679368713046380,9158679520113046617,9158765501413623749,9158765506713623893,
        9158765852713655292,9158765990713677153,9158868040613720248,9158902631413409231,9158902655113417022,9158920855113764760,9158922833013765924,9159076222913145176,
        9159333657713146360,9159342468813153037,9159598116113792107,9159598242113794620,9159599900413820010,9159600003813820300,9159600232413820774,9159600431413822925,
        9159606108113847198,9159832520413647453,9159996615213958827,9159997856013960056,9160003113713174887,9160004396413177343,9160005336613179559,9160005338613179626,
        9160005339513179725,9160005340313179837,9160005341013179880,9160007108413181802,9160008778713185480,9160131828513290174,9160131976913290422,9160132066213290463,
        9160132136213290728,9160481231813744826,9160489138513753314,9160740793513913123,9160756980013921835,9160757413713922310,9160757696113960893,9160758398113924017,
        9160758855913924410,9160759236113924762,9160759678413925252,9160760348513925471,9160760623013925897,9160778640613971882,9160778640613972032,9160778640613972183,
        9160778640613972340,9160778640713972741,9160783152413937285,9160783681513938034,9160783800613938254,9160783963513938658,9160790936213983318,9160793781113985396,
        9160793807913985645,9160794410513986950,9160794991713988494,9160795080613988672,9160795421013988942,9160817582413009448,9160841335813024135,9160841354113024242,
        9160842710413025868,9161326735313818009,9161327922013818773,9161327925313818860,9161344535813790770,9161344547513790834,9161405354213871936,9161939749713013049,
        9161940047213013867,9161940163113014305,9161940240813014780,9161940915813017165,9161941002913017228,9161941099013017914,9161942150113022881,9163030331105415128,
        9163030499140653773,9163031513028653788,9163031696206769062,9163037084307653795,9163124708344084645,9163135260441151686,9163135403091084657,9163135526652061346,
        9163135659101061360,9163144229460151704,9163144803221151715,9163279587472626356,9163340867998962488,9164245825262427609,9164391651805492557,9164411083891317690,
        9164421563967329072,9164424538817732410,9164427780355732455,9164433639746595587,9164473594655732515,9164477647489685616,9164480740197685642,9164724793808653956,
        9164750877368855173,9164776996817855305,9164777105567855308,9164797762492279241,9164921245738303446,9164921609742303449,9164930481832891008,9164964299686303505,
        9164972469540320362,9164975855622303556,9165106185211891435,9165145254229304004,9165145350387304017,9165207244170330274,9165217280138376936,9165343935932055635,
        9165716157950130353,9163650617215824463,9163651356941824466,9164777152779235032,9164957355082320278,9165027175625891243,9150228061313138077,9150228061313138081,
        9161395913999156675,9161396668136156681,9161396971893156688,9163636623480824402,9162961378188222564,9163530164804808684,9163391832183517373,9163575248523350216,
        9164687819225619719,9164714996125653916,9164732464740653985,9164845131032650101,9163106686052578035,9163106709330081965,9165052343933303829,9164681263436203640,
        9164930447491891002,9165017492822303687,9165025446331891226,9165051528615320600,9163160896328151744,9163160928915084756,9165882481503160638,9165882819782163049,
        9164239218576077245,9166063619556507137,9163418195457203791,9163444995750000385,9161733520972268654,9165357912177921450,9161011304513573902
    );
BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
    
    FOR i IN 1..NumArray.count LOOP

        /*** NO Alteration Price Component Validation ***/
        SELECT COUNT(*) INTO cnt  FROM nc_objects nco WHERE parent_id = NumArray(i);
        IF cnt = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('/* Promotion object_id: '|| NumArray(i) ||' Does NOT have Price Alteration Component AND is NOT Optik TV  -> SKIPED */');
            CONTINUE;
        END IF;

        /* Promo has TIC Promotion Category? */
        SELECT COUNT(*) INTO cnt FROM nc_references WHERE 
        attr_id = 9153770145313318210   /* ATTR_ID : Promotion Type */
        AND
        reference = 9153779179813323603 /* REFERENCE :  Tax Included Credits */ 
        AND
        object_id = NumArray(i);

        SELECT object_id INTO apc  FROM nc_objects nco WHERE parent_id = NumArray(i);

        /* NO: Promo doesnt have TIC Promotion Category */
        IF cnt = 0 THEN
            /* INSERT REFERENCE TO TIC PROMO CATEGORY */ 
            --INSERT INTO nc_references (attr_id,reference,object_id,show_order,priority,attr_access_type)
            --VALUES
            --( 
            --    9153770145313318210, /* ATTR_ID : Promotion Type */                
            --    9153779179813323603, /* REFERENCE :  Tax Included Credits */
            --    NumArray(i),
            --    6,
            --    0,
            --    0
            --);
            DBMS_OUTPUT.PUT_LINE('DELETE FROM nc_references WHERE attr_id = 9153770145313318210 AND reference = 9153779179813323603 AND object_id = '|| NumArray(i) ||';');
        END IF;

        /* Price Alteration has referece to tax code? */
        SELECT COUNT(*) INTO cnt FROM nc_references 
        WHERE attr_id = 9142883780313111933  /* ATTR_ID: Tax Code */ 
        AND object_id = (SELECT object_id  FROM nc_objects nco WHERE parent_id = NumArray(i));

        /*YES: DELETE REFERENCE TO Tax Code */
        IF cnt = 1 THEN
            --DELETE FROM nc_references WHERE 
            --attr_id = 9142883780313111933 /*Tax Code attr*/
            --AND object_id = (SELECT object_id  FROM nc_objects nco WHERE parent_id = NumArray(i)); /* Alteration Price Component */
            SELECT reference INTO old_tax_code FROM nc_references WHERE attr_id = 9142883780313111933 AND object_id = apc;
            DBMS_OUTPUT.PUT_LINE('INSERT INTO  nc_references (attr_id,reference,object_id,show_order,priority,attr_access_type) VALUES (9142883780313111933,'||old_tax_code||','||apc||',1,0,0);');
        END IF;
        
    END LOOP;
    

EXCEPTION
    WHEN OTHERS THEN
        
        DBMS_OUTPUT.PUT_LINE('E X C E P T I O N');
        v_code := SQLCODE;
        v_errm := SUBSTR(SQLERRM, 1, 64);
        DBMS_OUTPUT.PUT_LINE (v_code || ' ' || v_errm);
END;
/