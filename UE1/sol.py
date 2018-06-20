>>> P = 31675727281325656378650275815036870073075503506093135402668988284047582230234258467605688521782344760159754141735662356011193420947311608435850566404918185999411166623943087854416995350649389538088689024701566496830518110466657545746240238894635742584612647648574741137665161365376438908175977601791246452515120052838341341889194252726343466888112420237628121739378062616082491727663627584826886897737953481833310205201122493306313841163854788229633693940307629142860205555903044050314630648838699538450602895188464221389842416066181843607277208716588663905995818191725899117879649482087489834959698059351566304221403
>>> 
>>> Q = 28497686265003976932967492827814876126053526688089768434297027258547973656844021829433405129475698422210220679094220475615971021204575349605926645367638636763975543206043787150254881954824767093421635052255226162149827997054490835247762217121750428225345526082729129906702405444805143280151831892975282527272572414742821655184527236578920183260234854291993307443038415727197987382331851545279711338164589459823028219258734760681061056166427588313906571846826854891068445972876221166159875986207233297913681929018757143183334620197062287769843055074118580268298366704569946824088015465856635799714620572321038322893399
>>> 
>>> D = 351228556786482002318700635024635703212223208909347575617920551457610669781003404760573947887550254232124260803042831235326957091414911045016368255383726624341422135793499460414438436809847159199409174853261665627234722581880829556631694370960259648050436590185347940334345522192218651982353944047736865257919687790511965675559866683063944776206751949751341337652713367783771744895595392110764320436292966382619858594978378206414749358332100069019947938141901908809869463396714949027540157104195157335252825830675015480698819301476207123782580932687614525280195309166074700117924177359235153684941001270764101453441205817065225922395831709243489736848181380222278930714033650448939127540049540325467423795738224357664960624552269065505783940092227080804842824914407132586052262092373796561590304276044324592340466536395523541347134959140238352755592611659452094181199909692055193099249055834934847931264788252820771634832243986235683404751198123880285690844377944689173118286256793451163068652137312496448453152069027394579251137797232515017304638423284612213287374652797502842811767018200073815066983295143226674866391024566889460669384273814189499125270289814368289885792408382087873483624089675780977317504040065644196628912227473
>>> 
>>> C = 461485244601111084854715290387111565532455013809999000549373221707927376543011818613138257842868050688773587789042390217893531432153024543047737617527585105034381037047589793514338817570863789016864462001325612743796187778785519947792637996775403225446805711481656005736553445978998206058329285390777913545646716495173840275444405996192111238956875455897242068496309102534377008669199875012122406835798403975510638910716927849490541534210126776676217451117124499901485951258297216669553727345621310032111050135931009313064722425139631208965558244982224034493122182385372367333772168847047879398011574079642489062801233909367319378702321256945207601021841367259993111455273281270187856276960240962262335405281396496168796954866179001143626512760704079488853570726334167867365310971057913043528582565192547222560189711440740571551127562876071188901639428529441672819465171232180904776608667891380095643757344891416141488204765893874065726124056980866257216195083024101478434080685565868283999526343206725210092530045144782261391541590399124623162300426738062333633439455443727162184194322204297005694258492831416463387275729652286374372199726231807272641805074452637022137542390393596085268223135435085275798027612835862172760844073821
>>> pow(C,D,P)
937803456043790687411478477559015763542851917723690595515821726056053362066527077015695341831235227537386331200062271427069944364951006321032737095427908713499923126071501940925778890142614971362330781593167521797294607080741135939162492332146343840816796885711161583559200914433391055548001955239378549830932392901935844941601
>>> pow(C,D,P*Q)
937803456043790687411478477559015763542851917723690595515821726056053362066527077015695341831235227537386331200062271427069944364951006321032737095427908713499923126071501940925778890142614971362330781593167521797294607080741135939162492332146343840816796885711161583559200914433391055548001955239378549830932392901935844941601
>>> hex(pow(C,D,P*Q))
'0x4865757465206261636b206963682c206d6f7267656e2062726175206963682c20fc6265726d6f7267656e20686f6c2069636820646572204bf66e6967696e20696872204b696e643b206163682c20776965206775742064617373206e69656d616e6420776569df2c2064617373206963682052756d70656c7374696c7a6368656e20686569df21'
