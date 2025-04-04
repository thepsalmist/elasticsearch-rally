#!/bin/bash
LOCAL_PATH=$(pwd)
ES_HOST="http://host.docker.internal:9200"
TRACK_NAME="mc-query-benchmark"
INDEX_NAME="mc_search_url-000001"

# Track Dirs
mkdir -p ${LOCAL_PATH}/tracks/${TRACK_NAME}/operations
mkdir -p ${LOCAL_PATH}/tracks/${TRACK_NAME}/challenges

# Create track from INDEX_NAME
docker run --rm --name esrally-create \
  -v ${LOCAL_PATH}:/rally/.rally/ \
  elastic/rally create-track \
  --track=${TRACK_NAME} \
  --target-hosts=${ES_HOST} \
  --client-options="timeout:60" \
  --indices=${INDEX_NAME} \
  --output-path=/rally/.rally/tracks

echo "Tracks created in ${LOCAL_PATH}/tracks"

# Create the custom operations files
cat > ${LOCAL_PATH}/tracks/${TRACK_NAME}/operations/query-operations.json << 'EOF'
{
  "name": "test-query-with-uss",
  "operation-type": "search",
  "index": "${INDEX_NAME}",
  "body": {
    "query": {
      "bool": {
        "filter": [
          {
            "range": {
              "publication_date": {
                "gte": "2025-02-28",
                "lte": "2025-04-02"
              }
            }
          },
          {
            "query_string": {
              "query": "canonical_domain:(windsofchange.net OR delong.typepad.com OR socialistworker.org OR mydd.com OR newyorker.com OR velvetrevolution.us OR nationofchange.org OR peterbcollins.com OR mpetrelis.blogspot.com OR boomantribune.com OR plainblogaboutpolitics.blogspot.com OR justabovesunset.wordpress.com OR tinyrevolution.com OR baselinescenario.com OR democracynow.org OR mithras.blogs.com OR digbysblog.blogspot.com OR washingtonindependent.com OR thedailyshow.com OR thenation.com OR eschatonblog.com OR theliberalcurmudgeon.com OR usw.org OR newrepublic.com OR pacificfreepress.com OR cbpp.org OR andyworthington.co.uk OR immigrationimpact.com OR baltimorechronicle.com OR newshounds.us OR boldprogressives.org OR truenewsthebund.blogspot.com OR consortiumnews.com OR openleft.com OR treehugger.com OR vastleft.blogspot.co.uk OR thedemocraticdaily.com OR joeforindiana.com OR grittv.org OR thedailybanter.com OR democrats.org OR thenexthurrah.typepad.com OR desmogblog.com OR economistsview.typepad.com OR barackobama.com OR austinchronicle.com OR addictinginfo.org OR sideshow.me.uk OR lbo-news.com OR protectourelections.org OR phillyfreedom.blogspot.com OR congressmatters.com OR daytonos.com OR thepoorman.net OR rawstory.com OR brucespringsteen.net OR jonathanturley.org OR stubbornliberal.blogspot.com OR thedailybeast.com OR mediamatters.org OR coreyrobin.com OR rutherfordl.wordpress.com OR climatecentral.org OR altweeklies.com OR therealnews.com OR oldhickorysweblog.blogspot.com OR religiondispatches.org OR tomdispatch.com OR themiamihurricane.com OR mittromneyandcryingbabies.tumblr.com OR baywindows.com OR d-day.blogspot.com OR halfempth.blogspot.com OR directorblue.blogspot.com OR ourfuture.org OR ndn.org OR balkin.blogspot.com OR contrapauli.blogspot.com OR theinvestigativefund.org OR eclectablog.com OR spreadingromney.com OR chris-floyd.com OR pieceofmind.wordpress.com OR truthdig.com OR mondoweiss.net OR dneiwert.blogspot.com OR rogerailes.blogspot.com OR egbertowillies.com OR getfisaright.wordpress.com OR msn.com OR laborforsinglepayer.org OR moveon.org OR theroot.com OR offthekuff.com OR huffingtonpost.co.uk OR dissentingjustice.blogspot.com OR citypages.com OR scottwalkerwatch.com OR pollster.com OR pruningshears.us OR mittgetsworse.org OR thedemocraticstrategist.org OR livingliberally.org OR fi2w.org OR demconwatch.blogspot.com OR thesixthbrother.blogspot.com OR truth-out.org OR foxattacks.com OR politicususa.com OR newscorpse.com OR avedoncarol.blogspot.com OR democracyarsenal.org OR newsrackblog.com OR thenewcivilrightsmovement.com OR richardsilverstein.com OR willsteacy.blogspot.com OR chicagoreader.com OR restorefairness.org OR samuel-warde.com OR pressthink.org OR texaskaos.net OR thecarpetbaggerreport.com OR brainsandeggs.blogspot.com OR yda.org OR obama.com OR southchicagoan.blogspot.com OR thedailydolt.com OR wnymedia.net OR transequality.org OR locustfork.net OR towleroad.com OR obamatheconservative.com OR blogforiowa.com OR welcomebacktopottersville.blogspot.co.uk OR ilw.com OR dominionofnewyork.com OR irregulartimes.com OR genius.com OR huffingtonpost.com OR thewashingtonnote.com OR quickhits.tumblr.com OR echidneofthesnakes.blogspot.com OR gregpalast.com OR rightwingwatch.org OR btcnews.com OR nakedcapitalism.com OR talentedearthquake.blogspot.com OR tbogg.blogspot.com OR michael-hudson.com OR seattleforbarackobama.blogspot.com OR electoral-vote.com OR scripting.com OR welcome-to-pottersville2.blogspot.com OR hillaryis44.com OR freedemocracy.blogspot.com OR danshaviro.blogspot.com OR theimmoralminority.blogspot.com OR attackerman.com OR senate.gov OR holdfastblog.com OR tvsquad.com OR slate.com OR villagevoice.com OR madkane.com OR obsidianwings.blogs.com OR thefiscaltimes.com OR hurryupharry.org OR proteinwisdom.com OR ritholtz.com OR 21border.com OR bvblackspin.com OR alternet.org OR hekebolos.com OR reidreport.com OR aaa-fund.com OR pensitoreview.com OR bluestemprairie.com OR jobsanger.blogspot.com OR justforeignpolicy.org OR bendingleft.blogspot.com OR msnbc.com OR rideforrenewables.com OR hillaryis44.org OR fair.org OR harpers.org OR underthemountainbunker.wordpress.com OR mahablog.com OR roboromney.com OR lobotero.com OR dailykos.com OR howieinseattle.blogspot.com OR democrats.com OR cepr.net OR indecisionforever.com OR patriceayme.wordpress.com OR stephaniemiller.com OR nomoremister.blogspot.com OR fromtheleft.wordpress.com OR democraticunderground.com OR mediamattersaction.org OR groupnewsblog.net OR rollingstone.com OR whirledview.typepad.com OR immigrationequality.org OR washingtonnote.com OR romneytheliar.blogspot.com OR crooksandliars.com OR pandagon.net OR thescholarlyhooligan.blogspot.com OR redgreenandblue.org OR emptywheel.net OR motherjones.com OR threewisemen.blogspot.com OR americablog.com OR horsesass.org OR sfbayview.com OR dailyhowler.blogspot.co.uk OR vice.com OR equalityanddemocracy.org OR buzzmachine.com OR bobgeiger.blogspot.com OR dkosopedia.com OR lcv.org OR colbertnation.com OR grist.org OR dpatterson.blogspot.com OR zombietime.com OR tarsandsaction.org OR irc-online.org OR gawker.com OR whateveritisimagainstit.blogspot.com OR northcoastblog.com OR bradblog.com OR coloradoindependent.com OR esquire.com OR gothamist.com OR kottke.org OR i.am OR revolutionaryfrontlines.wordpress.com OR instaputz.blogspot.com OR antifascist-calling.blogspot.com OR readersupportednews.org OR esoterically.net OR jdeeth.blogspot.com OR ezraklein.com OR credoaction.com OR obamamessiah.blogspot.com OR politicaltruthusa.com OR allspinzone.com OR wonkette.com OR liberaldoomsayer.blogspot.com OR juancole.com OR hisvorpal.wordpress.com OR marketplayground.com OR mirroronamerica.blogspot.com OR talkingpointsmemo.com OR downwithtyranny.com OR nbcnews.com OR menaprogram.org OR calitics.com OR talkleft.com OR nprcheck.blogspot.com OR discoverthenetworks.org OR sourcewatch.org OR thelonggoodbye.wordpress.com OR opposingviews.com OR voxxi.com OR outsidethebeltway.com OR citizenstrade.org OR thehollywoodliberal.com OR historyunfolding.blogspot.com OR arktimes.com OR theatlantic.com OR electionlawblog.org OR current.tumblr.com OR americanprogressaction.org OR takemycountryback.com OR fpif.org OR tnr.com OR americanprogress.org OR blueoklahoma.org OR burntorangereport.com OR opednews.com OR medialens.org OR davidpakman.com OR itsoureconomy.us OR theglobeandmail.com OR bluevirginia.us OR theatlanticwire.com OR lawyersgunsmoneyblog.com OR hyperorg.com OR jedreport.com OR rodonline.typepad.com OR ohio15th.blogspot.com OR perrspectives.com OR shadowproof.com OR politicsdaily.com OR peaceblog.wordpress.com OR senateguru.com OR taylormarsh.com OR politic365.com OR roguecolumnist.typepad.com OR capitalgainsandgames.com OR danielmiessler.com OR alicublog.blogspot.com OR climatedepot.com OR shannynmoore.wordpress.com OR theleftcoaster.com OR bluejersey.com OR vagabondscholar.blogspot.com OR thebluevoice.blogspot.com OR salon.com OR teapartypledge.info OR policymic.com OR jezebel.com OR thinkprogress.org OR underthemountainbunker.com OR pickledpolitics.com OR robertreich.org OR digbysblog.blogspot.com.br) OR (canonical_domain:theguardian.com AND url:(http\\:\\/\\/theguardian.com\\/us\\/* OR https\\:\\/\\/theguardian.com\\/us\\/*))",
              "allow_leading_wildcard": true
            }
          }
        ],
        "must": [
          {
            "query_string": {
              "query": "(time OR play) -(office OR work)",
              "allow_leading_wildcard": false,
              "default_field": "text_content",
              "default_operator": "and"
            }
          }
        ]
      }
    },
    "aggs": {
      "dailycounts": {
        "date_histogram": {
          "calendar_interval": "day",
          "field": "publication_date",
          "min_doc_count": 1
        }
      },
      "toplangs": {
        "terms": {
          "field": "language.keyword",
          "size": 100
        }
      },
      "topdomains": {
        "terms": {
          "field": "canonical_domain",
          "size": 100
        }
      }
    },
    "track_total_hits": true,
    "size": 0,
    "_source": [
      "id",
      "indexed_date",
      "language",
      "canonical_domain",
      "publication_date",
      "article_title",
      "url"
    ]
  }
},
{
  "name": "test-query-without-uss",
  "operation-type": "search",
  "index": "${INDEX_NAME}",
  "body": {
    "query": {
      "bool": {
        "filter": [
          {
            "range": {
              "publication_date": {
                "gte": "2025-03-02",
                "lte": "2025-04-02"
              }
            }
          },
          {
            "query_string": {
              "query": "canonical_domain:(twincities.com OR reuters.com OR businessweek.com OR gawker.com OR ncregister.com OR stltoday.com OR stripes.com OR benzinga.com OR talkingnewmedia.com OR newsmax.com OR sbnation.com OR vox.com OR univision.com OR hollywoodweeklymagazine.com OR creators.com OR ajc.com OR newyorker.com OR livescience.com OR breitbart.com OR pbs.org OR theintercept.com OR abcnews.go.com OR people.com OR marketwatch.com OR sportingnews.com OR mlive.com OR pitchfork.com OR fusion.net OR theconversation.com OR indiancountrytoday.com OR newsbusters.org OR realclearpolitics.com OR vanityfair.com OR bizjournals.com OR barrons.com OR contactomagazine.com OR dailydot.com OR scientificamerican.com OR hollywoodlife.com OR newsblaze.com OR post-gazette.com OR scout.com OR investors.com OR nbcsports.com OR kapitall.com OR thenation.com OR bustle.com OR elnuevodia.com OR usnews.com OR armytimes.com OR slate.com OR monstersandcritics.com OR inquirer.com OR fortune.com OR americaru.com OR theguardian.com OR hotair.com OR ncronline.org OR theroot.com OR factcheck.org OR fansided.com OR oregonlive.com OR kansascity.com OR startribune.com OR theweek.com OR buffalonews.com OR bloomberg.com OR ledger-enquirer.com OR gq.com OR lexisnexis.com OR eurweb.com OR upi.com OR ign.com OR augustachronicle.com OR sandiegouniontribune.com OR bostonglobe.com OR talkingpointsmemo.com OR orlandosentinel.com OR billboard.com OR alternet.org OR nbcnews.com OR thestreet.com OR 247sports.com OR wsj.com OR zdnet.com OR rttnews.com OR spectator.org OR azcentral.com OR tmz.com OR qz.com OR ew.com OR observer.com OR accesshollywood.com OR townhall.com OR thrillist.com OR antena305.com OR tampabay.com OR breakingnews.com OR nationalmemo.com OR schwartzreport.net OR sun-sentinel.com OR arkansasonline.com OR dailycaller.com OR chicagotribune.com OR msnbc.com OR nypost.com OR truth-out.org OR berkshireeagle.com OR sfgate.com OR jsonline.com OR radaronline.com OR opposingviews.com OR harpers.org OR thewrap.com OR bleacherreport.com OR foxbusiness.com OR popmatters.com OR x17online.com OR usmagazine.com OR theatlantic.com OR arstechnica.com OR cherokeephoenix.org OR axcessnews.com OR fivethirtyeight.com OR nationalenquirer.com OR pilotonline.com OR dailykos.com OR pjmedia.com OR denverpost.com OR cleveland.com OR talkmedianews.com OR gazettenet.com OR tnr.com OR norwichbulletin.com OR cnet.com OR dailysource.org OR newsweek.com OR uproxx.com OR inquisitr.com OR omaha.com OR thepostgame.com OR courant.com OR recorder.com OR cnn.com OR theblaze.com OR opednews.com OR c-span.org OR baltimoresun.com OR navytimes.com OR nationalreview.com OR parade.com OR polygon.com OR eater.com OR eonline.com OR saturdayeveningpost.com OR newsone.com OR rawstory.com OR redherring.com OR npr.org OR mercurynews.com OR miamiherald.com OR csmonitor.com OR pressrepublican.com OR americanfreepress.net OR pewstates.org OR indiancountrynews.com OR cbsnews.com OR techradar.com OR indiewire.com OR pri.org OR variety.com OR colorlines.com OR oann.com OR latimes.com OR mashable.com OR opensecrets.org OR postandcourier.com OR syracuse.com OR rutlandherald.com OR ibtimes.com OR marinetimes.com OR theverge.com OR rollingstone.com OR businessinsider.com OR politico.com OR forbes.com OR dailysignal.com OR thedailybeast.com OR elitedaily.com OR cnsnews.com OR wired.com OR rollcall.com OR buzzfeed.com OR maxpreps.com OR mysanantonio.com OR therealnews.com OR nhgazette.com OR sacbee.com OR motherjones.com OR techcrunch.com OR mongabay.com OR airforcetimes.com OR newsday.com OR propublica.org OR chron.com OR axs.com OR dallasnews.com OR foxnews.com OR dispatch.com OR freep.com OR gizmodo.com OR hollywoodreporter.com OR engadget.com OR centralmaine.com OR newsy.com OR vice.com OR polamjournal.com OR salon.com OR mintpressnews.com OR patriotpost.us OR seattletimes.com OR foxsports.com OR staradvertiser.com OR jezebel.com OR nytimes.com OR cincinnati.com OR ibabuzz.com OR providencejournal.com OR refinery29.com OR huffingtonpost.com OR cbssports.com OR washingtonpost.com OR time.com OR philly.com OR indystar.com OR usatoday.com OR sentinelsource.com OR hudsonvalley360.com OR grist.org OR redstate.com OR ocregister.com OR deadspin.com OR cnbc.com OR politicalwire.com OR mic.com OR weeklystandard.com OR fayobserver.com OR espn.com)",
              "allow_leading_wildcard": true
            }
          }
        ]
      }
    },
    "aggs": {
      "dailycounts": {
        "date_histogram": {
          "calendar_interval": "day",
          "field": "publication_date",
          "min_doc_count": 1
        }
      },
      "toplangs": {
        "terms": {
          "field": "language.keyword",
          "size": 100
        }
      },
      "topdomains": {
        "terms": {
          "field": "canonical_domain",
          "size": 100
        }
      }
    },
    "track_total_hits": true,
    "size": 0,
    "_source": [
      "id",
      "indexed_date",
      "language",
      "canonical_domain",
      "publication_date",
      "article_title",
      "url"
    ]
  }
},
{
  "name": "test-simpler-query",
  "operation-type": "search",
  "index": "${INDEX_NAME}",
  "body": {
    "query": {
      "bool": {
        "filter": [
          {
            "query_string": {
              "query": "canonical_domain:(nytimes.com)",
              "allow_leading_wildcard": true
            }
          },
          {
            "range": {
              "publication_date": {
                "gte": "2025-03-02",
                "lte": "2025-04-02"
              }
            }
          }
        ],
        "must": [
          {
            "query_string": {
              "query": "broadway",
              "allow_leading_wildcard": false,
              "default_field": "text_content",
              "default_operator": "and"
            }
          }
        ]
      }
    },
    "aggs": {
      "dailycounts": {
        "date_histogram": {
          "calendar_interval": "day",
          "field": "publication_date",
          "min_doc_count": 1
        }
      },
      "toplangs": {
        "terms": {
          "field": "language.keyword",
          "size": 100
        }
      },
      "topdomains": {
        "terms": {
          "field": "canonical_domain",
          "size": 100
        }
      }
    },
    "track_total_hits": true,
    "size": 0,
    "_source": [
      "id",
      "indexed_date",
      "language",
      "canonical_domain",
      "publication_date",
      "article_title",
      "url"
    ]
  }
}
EOF
echo "Operations file created in ${LOCAL_PATH}/tracks/${TRACK_NAME}/challenges"

# Create the challenge file
cat > ${LOCAL_PATH}/tracks/${TRACK_NAME}/challenges/query-comparison.json << 'EOF'
{
  "name": "query-comparison",
  "default": true,
  "description": "Compare performance of different query patterns",
  "schedule": [
    {
      "operation": "test-query-with-uss",
      "warmup-iterations": 5,
      "iterations": 50,
      "clients": 1
    },
    {
      "operation": "test-query-without-uss",
      "warmup-iterations": 5,
      "iterations": 50,
      "clients": 1
    },
    {
      "operation": "test-simpler-query",
      "warmup-iterations": 5,
      "iterations": 50,
      "clients": 1
    }
  ]
}
EOF
echo "Challanges file created in ${LOCAL_PATH}/tracks/${TRACK_NAME}/challenges"

# Create the track.json file
# cat > ${LOCAL_PATH}/tracks/${TRACK_NAME}/track.json << 'EOF'
# {% import "rally.helpers" as rally with context %}
# {
#   "version": 2,
#   "description": "Benchmark comparing different query patterns",
#   "indices": [
#     {
#       "name": "${INDEX_NAME}",
#       "body": "index.json"
#     }
#   ],
#   "operations": [
#     {{ rally.collect(parts="operations/*.json") }}
#   ],
#   "challenges": [
#     {{ rally.collect(parts="challenges/*.json") }}
#   ]
# }
# EOF

# echo "Track created in ${LOCAL_PATH}/tracks/${TRACK_NAME}"

