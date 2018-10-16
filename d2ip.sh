#Built by BlkPh0x
#Not to be used for illegal activitys
#i will not be held accountable for missuse of this software/program
#this program takes a domain name translates to an ip and will scan the ip range associated with the host
#at time will assit in locating services running on the same ip range 
echo "USEAGE bash ./LulzScanner.sh HOST"
echo "HOST = DomainName eg.(google.com, ebay.com)" 
HOST1=$1 
proc=$2 
HOST=$(ping -c 1 $HOST1 -4 | grep -oE "\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b" | uniq) &&
baseip=$(echo $HOST | cut -d"." -f1-3) 
echo $baseip".0/24" 
nmap -v -sn -oG - $baseip.0/24 | awk '/Up/ {print $2}' > $HOST1._internl_struc 
cat $HOST1._internl_struc | 
while read F; do nmap -v -oG - $F | awk '/open/ {for (i = 0; i<= NF; i++)print $i}' >> $HOST1._range_scan & done
echo "starting tail, to quit ctrl+C Sleeping for 10s first..." 
sleep 10
tail -f $HOST1._range_scan

