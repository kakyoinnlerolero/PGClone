#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
oauthcheck () {
pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Conducting Validation Checks: $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rcheck=$(rclone lsd --config /pg/data/blitz/.$oauthcheck $oauthcheck: | grep -oP plexguide | head -n1)
  if [[ "$rcheck" != "plexguide" ]]; then
    rclone mkdir --config /pg/data/blitz/.$oauthcheck $oauthcheck:/plexguide
    rcheck=$(rclone lsd --config /pg/data/blitz/.$oauthcheck $oauthcheck: | grep -oP plexguide | head -n1)
  fi

  if [ "$rcheck" != "plexguide" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  Validation Checks Failed: $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTES:
1. Did you set up your $oauthcheck accordingly to the wiki?
2. Is your project active?

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
rm -rf /pg/data/blitz/.$oauthcheck 1>/dev/null 2>&1

    if [[ "$oauthcheck" == "gdrive" ]]; then rm -rf /pg/data/blitz/.gcrypt 1>/dev/null 2>&1; fi
    if [[ "$oauthcheck" == "tdrive" ]]; then rm -rf /pg/data/blitz/.tcrypt 1>/dev/null 2>&1; fi

    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed2 < /dev/tty
    clonestart
else
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 System Message: Validation Checks Passed - $oauthcheck
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  fi
}
