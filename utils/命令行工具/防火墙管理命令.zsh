# ufw : Uncomplicated Firewall
    ufw status verbose
    ufw enable / disable
#   allow:
    ufw allow <port>[/<protocol>]
    ufw allow <port>:<port>/<protocol>
#   deny:
    ufw deny <port>/<optional: protocol>
#   delete:
    ufw delete deny 80/tcp
#   default:
    ufw default allow/deny
#   log:
    ufw logging on/off
