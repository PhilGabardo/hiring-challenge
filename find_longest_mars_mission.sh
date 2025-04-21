# find_longest_mars_mission.sh
#!/bin/bash

awk -F'|' '
  !/^#/ && !/^CHECKPOINT/ && !/^SYSTEM/ && !/^CONFIG/ && !/^CHECKSUM/ && NF > 1 {
    gsub(/^[ \t]+|[ \t]+$/, "", $3);
    gsub(/^[ \t]+|[ \t]+$/, "", $4);
    gsub(/^[ \t]+|[ \t]+$/, "", $6);
    gsub(/^[ \t]+|[ \t]+$/, "", $8);
    
    if ($3 == "Mars" && $4 == "Completed") {
      duration = $6 + 0;
      
      if (duration > max_duration) {
        max_duration = duration;
        security_code = $8;
      }
    }
  }
  END {
    print "Security code of longest successful Mars mission: " security_code;
    print "Duration: " max_duration " days";
  }
' space_missions.log
