Config { overrideRedirect = False
       , font     = "xft:JetBrainsMono NF-12"
       , bgColor  = "#170d1f"
       , fgColor  = "#f8f8f2"
       -- , position = TopW C 95
	   , position = TopH 40
       , commands = [ Run Weather "EGPF"
                        [ "--template", "<weather> <tempC>°C"
                        , "-L", "0"
                        , "-H", "25"
                        , "--low"   , "lightblue"
                        , "--normal", "#f8f8f2"
                        , "--high"  , "red"
                        ] 36000
                    , Run Cpu
                        [ "-L", "3"
                        , "-H", "50"
                        , "--high"  , "red"
                        , "--normal", "green"
                        ] 10
                    , Run Alsa "default" "Master"
                        [ "--template", "<volumestatus>"
                        , "--suffix"  , "True"
                        , "--"
                        , "--on", ""
                        ]
                    , Run Memory ["--template", "Mem: <usedratio>%"] 10
                    , Run Swap [] 10
                    , Run Date "%a %Y-%m-%d <fc=#8be9fd>%H:%M:%S</fc>" "date" 10
                    , Run XMonadLog
					, Run Battery ["-t", "Batt: <left>% <timeleft>"] 10
                    ]
       , sepChar  = "%"
       , alignSep = "}{"
       , template = "%XMonadLog% }{ %cpu% | %battery% | %memory% | %EGPF% | %date%"
       }

