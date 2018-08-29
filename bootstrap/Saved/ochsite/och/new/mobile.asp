<html>
<head>
</head>
<body id ="page">
<form id="och_search" action="search.asp" method="post" class="form">
    <h1>Search 
        <span>Please fill all the texts in the fields.</span>
    </h1>
    <label>
        <span>Rent Min:</span>
        <input id="rent_min" type="text" name="rent_min" />
    </label>
    
    <label>
        <span>Rent Max:</span>
        <input id="rent_max" type="text" name="rent_max" />
    </label>
    
    <label>
        <span>Bedrooms Available:</span>
        <input id="bedrooms_available" type="text" name="bedrooms_available" />
    </label>
    
    <label>
        <span>Bedrooms Available:</span>
        <input id="bedrooms_available" type="text" name="bedrooms_available" />
    </label> 
    
     <label>
        <span>Area (<a href="resources.asp#areas">about</a>):</span>
        <select name="area" id="area">
            <option></option> <!-- blank line -->
            <option>Allentown</option>
            <option>Buff State</option>
            <option>Downtown</option>
            <option>Elmwood</option>
            <option>North Buffalo/Hertel</option>
            <option>Parkside</option>
            <option>University Heights</option>
            <option>Amherst</option>
            <option>Tonawanda</option>
            <option></option> <!-- blank line -->
            <option>Akron</option>
            <option>Allentown</option>
            <option>Amherst</option>
            <option>Blasdell</option>
            <option>Boston</option>
            <option>Buff State</option>
            <option>Buffalo</option>
            <option>Cheektowaga</option>
            <option>Clarence</option>
            <option>Clarence Center</option>
            <option>Depew</option>
            <option>Downtown</option>
            <option>East Amherst</option>
            <option>East Aurora</option>
            <option>Eden</option>
            <option>Eggertsville</option>
            <option>Elmwood Village</option>
            <option>Getzville</option>
            <option>Grand Island</option>
            <option>Hamburg</option>
            <option>Kenmore</option>
            <option>Lackawanna</option>
            <option>Lancaster</option>
            <option>Lockport</option>
            <option>Niagara Falls</option>
            <option>North Buffalo/Hertel</option>
            <option>North Tonawanda</option>
            <option>Orchard Park</option>
            <option>Parkside</option>
            <option>Sloan</option>
            <option>Snyder</option>
            <option>South Cheektowaga</option>
            <option>Swormville</option>
            <option>Tonawanda</option>
            <option>University Heights</option>
            <option>West Seneca</option>
            <option>Williamsville</option>
        </select>
     </label>
     
     <label>
        <span>Unit Type:</span>
        <select name="unit_type" id="unit_type">
            <option></option> <!-- blank line -->
            <option value='1'>Apartment</option>
            <option value='2'>Lower flat</option>
            <option value='3'>Upper flat</option>
            <option value='4'>Room in private house</option>
            <option value='5'>Whole house</option>
            <option value='6'>Studio</option>
            <option value='7'>Duplex</option>
            <option value='8'>Sublet</option>
            <option value=''>All Types</option>
        </select>
     </label>
     
     <label>
        <span>Street</span>
        <select name='street' id='street'>
            <option value=''>Any</option>
            <option>17th st.</option>
            <option>Abbotts ford pl.</option>
            <option>Addison</option>
            <option>Agyle</option>
            <option>Albert dr.</option>
            <option>Alberta dr.</option>
            <option>Alcona</option>
            <option>Alcona ave.</option>
            <option>Allen st.</option>
            <option>Allenhurst</option>
            <option>American campus drive</option>
            <option>Amherst manor dr.</option>
            <option>Amherst st.</option>
            <option>Andover</option>
            <option>Arend avenue</option>
            <option>Ariellecourt</option>
            <option>Arlington road</option>
            <option>Ashburn ave.</option>
            <option>Ashland ave.</option>
            <option>Astor ridge drive</option>
            <option>Atlantic ave.</option>
            <option>Atwood</option>
            <option>Auburn ave.</option>
            <option>Bailey ave.</option>
            <option>Baron ct.</option>
            <option>Barton</option>
            <option>Bathhurst dr.</option>
            <option>Beach rd.</option>
            <option>Beach ridge rd.</option>
            <option>Bear ridge rd.</option>
            <option>Beard ave.</option>
            <option>Beaumont dr.</option>
            <option>Beech meadow ct.</option>
            <option>Beech rd</option>
            <option>Beech rd.</option>
            <option>Beehunter ct.</option>
            <option>Belcourt</option>
            <option>Belmont ave.</option>
            <option>Belvoir rd.</option>
            <option>Berehaven</option>
            <option>Berkley</option>
            <option>Berkshire ave.</option>
            <option>Bernhadt dr.</option>
            <option>Bernhardt dr.</option>
            <option>Berryman rd.</option>
            <option>Bidwell parkway</option>
            <option>Bird ave.</option>
            <option>Blackmore</option>
            <option>Blake st.</option>
            <option>Bluebird lane</option>
            <option>Bluebird ln.</option>
            <option>Blvd towers</option>
            <option>Bobben</option>
            <option>Bodine rd</option>
            <option>Boston cross rd.</option>
            <option>Brantford place</option>
            <option>Brantwood rd.</option>
            <option>Bridlewood dr.</option>
            <option>Brighton rd.</option>
            <option>Brinton st.</option>
            <option>Brittany</option>
            <option>Broad st.</option>
            <option>Brookfield lane</option>
            <option>Brooklane</option>
            <option>Bruce</option>
            <option>Bruce st.</option>
            <option>Brush creek</option>
            <option>Bryant</option>
            <option>Burroughs dr.</option>
            <option>Busti ave.</option>
            <option>Byron ave.</option>
            <option>California rd.</option>
            <option>Callodine ave.</option>
            <option>Cambridge</option>
            <option>Camden ave.</option>
            <option>Campbell blvd.</option>
            <option>Campus dr.</option>
            <option>Campus drive north</option>
            <option>Canterbury ct.</option>
            <option>Capen blvd.</option>
            <option>Carmel rd.</option>
            <option>Carmen ave.</option>
            <option>Cascade dr.</option>
            <option>Cayuga</option>
            <option>Chapel ave.</option>
            <option>Charelsgate</option>
            <option>Charlesgate circle</option>
            <option>Charter oaks</option>
            <option>Chasewood lane</option>
            <option>Cherrywood</option>
            <option>Cherrywood dr.</option>
            <option>Chestnut ridge rd.</option>
            <option>Christiana</option>
            <option>Claremont</option>
            <option>Clearfield dr.</option>
            <option>Cleveland</option>
            <option>Clinton st.</option>
            <option>Colonial cir.</option>
            <option>Colonial dr.</option>
            <option>Colvin ave.</option>
            <option>Commonwealth ave.</option>
            <option>Comstock</option>
            <option>Concord dr.</option>
            <option>Connection drive</option>
            <option>Cordova</option>
            <option>Cornell ave</option>
            <option>Countryside ln.</option>
            <option>Courtland</option>
            <option>Coventry green circle</option>
            <option>Cramer st.</option>
            <option>Creekside dr.</option>
            <option>Creekside village</option>
            <option>Crescent ave.</option>
            <option>Crestmount</option>
            <option>Crestwood ave.</option>
            <option>Crosby ave</option>
            <option>Cunard rd.</option>
            <option>Cunard st.</option>
            <option>Custer st.</option>
            <option>Dale dr.</option>
            <option>Dartmouth ave.</option>
            <option>Delamere rd.</option>
            <option>Delaware ave.</option>
            <option>Denrose</option>
            <option>Devereaux</option>
            <option>Dewey ave.</option>
            <option>Dewitt</option>
            <option>Dockside dr</option>
            <option>Dockside parkway</option>
            <option>Dockside pkwy</option>
            <option>Dodge road</option>
            <option>Draden ln.</option>
            <option>Durham dr.</option>
            <option>Dysinger rd.</option>
            <option>E end ave.</option>
            <option>E. lovejoy st.</option>
            <option>Eagle st.</option>
            <option>East amherst</option>
            <option>East depew ave</option>
            <option>East depew ave.</option>
            <option>East northrup pl.</option>
            <option>East st.</option>
            <option>East summerset</option>
            <option>Edward st</option>
            <option>Eggert rd.</option>
            <option>Eiss pl.</option>
            <option>Ellen drive</option>
            <option>Elm road</option>
            <option>Elmhurst pl.</option>
            <option>Elmwood ave.</option>
            <option>Emerson dr.</option>
            <option>Englewood ave.</option>
            <option>Esther</option>
            <option>Evans st.</option>
            <option>Exchange st.</option>
            <option>Fairelm</option>
            <option>Fairelm lane</option>
            <option>Faireln lane</option>
            <option>Fairfield ave.</option>
            <option>Falconer</option>
            <option>Fletcher st.</option>
            <option>Flickinger ct.</option>
            <option>Florence ave</option>
            <option>Florida st.</option>
            <option>Flower st.</option>
            <option>Fordham dr.</option>
            <option>Forest</option>
            <option>Foxberry dr.</option>
            <option>Frankhauser</option>
            <option>Frankhauser rd</option>
            <option>Franklin</option>
            <option>Freeman</option>
            <option>Garden ct.</option>
            <option>Gardenwood ln.</option>
            <option>Garnet road</option>
            <option>Garrison rd</option>
            <option>Gaspe drive</option>
            <option>Genesee st.</option>
            <option>George</option>
            <option>George urban blvd</option>
            <option>Germain st.</option>
            <option>Getzville</option>
            <option>Ginger ct.</option>
            <option>Glen ave</option>
            <option>Glen oak drive</option>
            <option>Glendale rd.</option>
            <option>Glenhaven</option>
            <option>Glenhurst</option>
            <option>Gordon</option>
            <option>Goundry</option>
            <option>Goundry street</option>
            <option>Grand island blvd.</option>
            <option>Grandview</option>
            <option>Grandview ave.</option>
            <option>Granger place</option>
            <option>Green acres rd.</option>
            <option>Greenfield</option>
            <option>Greenfield st.</option>
            <option>Greenwich</option>
            <option>Groton dr.</option>
            <option>Grove</option>
            <option>Groveland</option>
            <option>Grover cleveland highway</option>
            <option>Haller ave.</option>
            <option>Halwill</option>
            <option>Hamilton</option>
            <option>Harlem rd.</option>
            <option>Harrogate sq.</option>
            <option>Hartford</option>
            <option>Hartwell rd.</option>
            <option>Hawthorne</option>
            <option>Hawthorne ave.</option>
            <option>Hawthrone ave.</option>
            <option>Haymarket square</option>
            <option>Heath st.</option>
            <option>Hedge ct.</option>
            <option>Hedley st.</option>
            <option>Heim rd</option>
            <option>Hemlock rd.</option>
            <option>Hendricks blvd.</option>
            <option>Henel</option>
            <option>Henley rd.</option>
            <option>Hennepin road</option>
            <option>Hennipin rd.</option>
            <option>Henrietta st.</option>
            <option>Hertel ave.</option>
            <option>Hewitt ave.</option>
            <option>Hickory hill rd.</option>
            <option>Highgate ave.</option>
            <option>Highland ave.</option>
            <option>Highland dr.</option>
            <option>Hinds</option>
            <option>Hinman ave.</option>
            <option>Hirschfield dr.</option>
            <option>Hodge ave.</option>
            <option>Holly ln.</option>
            <option>Holmes ave</option>
            <option>Holmes st.</option>
            <option>Homecrest dr.</option>
            <option>Homer lane</option>
            <option>Homewood ct.</option>
            <option>Hopkin rd.</option>
            <option>Howard ave</option>
            <option>Humboldt parkway</option>
            <option>Hunting valley</option>
            <option>Huntington</option>
            <option>Ivyhurst cir.</option>
            <option>Jeffrey st</option>
            <option>Jewett parkway</option>
            <option>Joe mccarthy dr.</option>
            <option>Kay st.</option>
            <option>Kaymar dr</option>
            <option>Kelvin dr.</option>
            <option>Kenmore ave.</option>
            <option>Kennedy</option>
            <option>Kenova</option>
            <option>Kensington ave.</option>
            <option>Kenview boulevard</option>
            <option>Kenville rd.</option>
            <option>Keph drive</option>
            <option>Keph rd.</option>
            <option>Kings highway</option>
            <option>Klauder</option>
            <option>Knowlton</option>
            <option>Knowlton ave.</option>
            <option>Knox</option>
            <option>Koster row</option>
            <option>Lafayette</option>
            <option>Lakewood</option>
            <option>Lakewood pkwy</option>
            <option>Lamarck</option>
            <option>Lamont st.</option>
            <option>Lancaster ave.</option>
            <option>Larch road</option>
            <option>Lardner</option>
            <option>Lasalle ave.</option>
            <option>Lawnwood dr.</option>
            <option>Layton ave.</option>
            <option>Lebrun</option>
            <option>Lebrun rd.</option>
            <option>Lemans</option>
            <option>Lemans dr.</option>
            <option>Lemontree</option>
            <option>Lemontree court</option>
            <option>Leonore rd.</option>
            <option>Lexington ave.</option>
            <option>Linden ave</option>
            <option>Linview terrace</option>
            <option>Linwood</option>
            <option>Lisbon ave.</option>
            <option>Lockport area</option>
            <option>Locust st</option>
            <option>Longmeadow</option>
            <option>Longnecker st.</option>
            <option>Los robles</option>
            <option>Los robles ave.</option>
            <option>Lovering ave.</option>
            <option>Lyndale ave.</option>
            <option>Main st.</option>
            <option>Mallony</option>
            <option>Mallory</option>
            <option>Manchester place</option>
            <option>Manor oak dr.</option>
            <option>Maple court</option>
            <option>Maple rd.</option>
            <option>Mapleview rd.</option>
            <option>Marian drive</option>
            <option>Mariemont</option>
            <option>Marine</option>
            <option>Marine dr.</option>
            <option>Mariner st.</option>
            <option>Marion drive</option>
            <option>Mckinley pkwy.</option>
            <option>Mead st.</option>
            <option>Meadow lea</option>
            <option>Meadowbrook</option>
            <option>Melrose rd.</option>
            <option>Merrimac</option>
            <option>Meyer</option>
            <option>Meyer rd.</option>
            <option>Midland ave.</option>
            <option>Military rd</option>
            <option>Mill street</option>
            <option>Millersport hwy.</option>
            <option>Millrace north</option>
            <option>Minnesota ave.</option>
            <option>Montrose</option>
            <option>Morgan st</option>
            <option>Mount vernon</option>
            <option>Mt. venon</option>
            <option>Mt. vernon</option>
            <option>Mullen</option>
            <option>N. maplemere</option>
            <option>Nadon pl.</option>
            <option>New rd.</option>
            <option>Newell ave.</option>
            <option>Niagara falls blvd.</option>
            <option>Niagara st</option>
            <option>Niagra falls blvd.</option>
            <option>Nicholson</option>
            <option>Noel</option>
            <option>North bailey ave.</option>
            <option>North davis rd.</option>
            <option>North dr.</option>
            <option>North ellicot</option>
            <option>North ellicott</option>
            <option>North ellicott creek rd.</option>
            <option>North forest rd.</option>
            <option>North french rd</option>
            <option>North long</option>
            <option>North maplemere</option>
            <option>North park</option>
            <option>North pearl</option>
            <option>North st.</option>
            <option>Northrup pl.</option>
            <option>Northumberland</option>
            <option>Northwood dr.</option>
            <option>Norwalk ave.</option>
            <option>Norwood ave.</option>
            <option>Nottingham</option>
            <option>Oak court</option>
            <option>Oakbrook dr.</option>
            <option>Oakridge ave.</option>
            <option>Old lyme dr.</option>
            <option>Old orchard</option>
            <option>Oliver st.</option>
            <option>Orchard drive</option>
            <option>Orchard pl.</option>
            <option>Other street</option>
            <option>Paige ave.</option>
            <option>Palmdale dr.</option>
            <option>Paradise ln.</option>
            <option>Paradise rd.</option>
            <option>Park street</option>
            <option>Parkdale ave.</option>
            <option>Parkridge</option>
            <option>Parkside ave.</option>
            <option>Parkside ct.</option>
            <option>Parkwood ave.</option>
            <option>Patricia dr.</option>
            <option>Payne ave,</option>
            <option>Payne ave.</option>
            <option>Pennsylvania ave.</option>
            <option>Peppertree dr.</option>
            <option>Pheasent run</option>
            <option>Phylliss ave.</option>
            <option>Pierpont ave.</option>
            <option>Pin oak drive</option>
            <option>Pine ridge rd.</option>
            <option>Pinetree court</option>
            <option>Ponderosa drive</option>
            <option>Potomac ave</option>
            <option>Prarie ave.</option>
            <option>Princeton ave.</option>
            <option>Prospect ave.</option>
            <option>Pryor ave.</option>
            <option>Radcliffe rd.</option>
            <option>Raintree apt.</option>
            <option>Ramsdell ave.</option>
            <option>Ranch trail west</option>
            <option>Rand</option>
            <option>Rand ave.</option>
            <option>Randwood ct.</option>
            <option>Red fern ct.</option>
            <option>Redmond st</option>
            <option>Reiman st.</option>
            <option>Reist st</option>
            <option>Rensch rd.</option>
            <option>Reservation st.</option>
            <option>Richmond</option>
            <option>Ridge road</option>
            <option>Rinewalt st.</option>
            <option>Riverdale</option>
            <option>Robert dr.</option>
            <option>Robin road</option>
            <option>Robinhill dr.</option>
            <option>Rockdale drive</option>
            <option>Rounds ave.</option>
            <option>Rowley rd.</option>
            <option>Roycroft</option>
            <option>Rugby</option>
            <option>Rumson road</option>
            <option>Saint florian</option>
            <option>Sanders rd.</option>
            <option>Saranac ave.</option>
            <option>Scam ridge curve</option>
            <option>School st.</option>
            <option>Sean riley court</option>
            <option>Sedgemoor ct.</option>
            <option>Segsbury rd.</option>
            <option>Seneca st.</option>
            <option>Seneca street</option>
            <option>Sheridan dr.</option>
            <option>Shirley ave.</option>
            <option>Shoshone</option>
            <option>Shoshone st.</option>
            <option>Skinnerville rd.</option>
            <option>Smith rd.</option>
            <option>South century ave.</option>
            <option>South ellicot st.</option>
            <option>South ellicott creek rd.</option>
            <option>South seine</option>
            <option>Southwedge</option>
            <option>Southwind tr.</option>
            <option>Springmeadow drive</option>
            <option>Springville ave.</option>
            <option>Spruce</option>
            <option>Spruce road</option>
            <option>St. amelia dr.</option>
            <option>St. florian</option>
            <option>St. james place</option>
            <option>St. margarets ct.</option>
            <option>Starin ave.</option>
            <option>Sterling ave.</option>
            <option>Sterling rd.</option>
            <option>Stevenson blvd.</option>
            <option>Stillwell</option>
            <option>Stockbridge ave.</option>
            <option>Stratford</option>
            <option>Suffolk</option>
            <option>Sugnet</option>
            <option>Summer</option>
            <option>Sun down trail</option>
            <option>Sundown trail</option>
            <option>Sundridge dr.</option>
            <option>Sunmist sq.</option>
            <option>Sunridge dr</option>
            <option>Sunshine dr.</option>
            <option>Sweeny</option>
            <option>Sweet home rd.</option>
            <option>Sweethome road</option>
            <option>Tacoma</option>
            <option>Taunton pl.</option>
            <option>The courtyards</option>
            <option>Thorncliffe</option>
            <option>Tioga st.</option>
            <option>Tonawanda creek road</option>
            <option>Tralee terrace</option>
            <option>Transit rd.</option>
            <option>Traverse st</option>
            <option>Traymore st.</option>
            <option>Tristan lane</option>
            <option>Tulane rd</option>
            <option>Tuxedo</option>
            <option>Tyler st.</option>
            <option>Union road</option>
            <option>University ave.</option>
            <option>Vandervoort st.</option>
            <option>Vernon place</option>
            <option>Via pinto drive</option>
            <option>Villa</option>
            <option>Villa avenue</option>
            <option>Vine la.</option>
            <option>Virgil ave.</option>
            <option>Virginia place</option>
            <option>Virginia st.</option>
            <option>Voorhees</option>
            <option>W. toulon dr.</option>
            <option>W. winspear</option>
            <option>Walnut st</option>
            <option>Walton ave.</option>
            <option>Walton dr.</option>
            <option>Washington</option>
            <option>Wehrle st.</option>
            <option>Wellington</option>
            <option>West cleveland dr.</option>
            <option>West delavan</option>
            <option>West ferry</option>
            <option>West ferry st</option>
            <option>West northrup</option>
            <option>West northrup</option>
            <option>West oakfield rd.</option>
            <option>West oakfield st.</option>
            <option>West summerset</option>
            <option>West utica</option>
            <option>West winspear ave.</option>
            <option>Westfield rd.</option>
            <option>Westminster ave.</option>
            <option>Wheaton ave</option>
            <option>Wheaton dr.</option>
            <option>Whitney pl</option>
            <option>Wiley st.</option>
            <option>Willet</option>
            <option>Willett st.</option>
            <option>Willow dr.</option>
            <option>Willow ridge dr.</option>
            <option>Windermere</option>
            <option>Winspear ave.</option>
            <option>Winston</option>
            <option>Wm. price pkwy</option>
            <option>Woodcrest dr.</option>
            <option>Woodette  pl.</option>
            <option>Woodpointe run</option>
            <option>Woodward ave.</option>
            <option>Zelmer st.</option>
            <option>Zimmerman st.</option>
        </select>
    </label>
    
    <label>
        <span>More Options</span>
        <fieldset>
            <div class="item">
                <input type='checkbox' name='features' value='heat' id='feature-heat' />
                <label for='feature-heat'>Heat</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='gas' id='feature-gas' />
                <label for='feature-gas'>Gas</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='water' id='feature-water' />
                <label for='feature-water'>Water</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='electric' id='feature-electric' />
                <label for='feature-electric'>Electric</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='cable' id='feature-cable' />
                <label for='feature-cable'>Cable</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='internet' id='feature-internet' />
                <label for='feature-internet'>Internet</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='garbage_collection' id='feature-garbage_collection' />
                <label for='feature-garbage_collection'>Garbage Collection</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='central_air' id='feature-central_air' />
                <label for='feature-central_air'>Central Air</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='stove' id='feature-stove' />
                <label for='feature-stove'>Stove</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='refrigerator' id='feature-refrigerator' />
                <label for='feature-refrigerator'>Refrigerator</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='furnished' id='feature-furnished' />
                <label for='feature-furnished'>Furnished</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='washer' id='feature-washer' />
                <label for='feature-washer'>Washer</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='dryer' id='feature-dryer' />
                <label for='feature-dryer'>Dryer</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='storm_windows' id='feature-storm_windows' />
                <label for='feature-storm_windows'>Storm Windows</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='insulated' id='feature-insulated' />
                <label for='feature-insulated'>Insulated</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='garage' id='feature-garage' />
                <label for='feature-garage'>Garage</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='off-street_parking' id='feature-off-street_parking' />
                <label for='feature-off-street_parking'>Off-street Parking</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='dogs_allowed' id='feature-dogs_allowed' />
                <label for='feature-dogs_allowed'>Dogs Allowed</label>
            </div>
            <div class="item">
                <input type='checkbox' name='features' value='cats_allowed' id='feature-cats_allowed' />
                <label for='feature-cats_allowed'>Cats Allowed</label>
            </div>
        </fieldset>
    </label>
    <input type="submit" class="button" value="Search Listings" />    
</form>
</body>
</html>
