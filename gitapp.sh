#!/bin/bash
red="\e[31m"
W="\033[1;36m"
green="\e[32m"
yellow="\e[33m"
bold=$(tput bold)
normal=$(tput sgr0)
right=$(printf '\xE2\x9C\x94')
end="\e[0m"

banner() {
[ "$silent" == False ] && echo "👊👊👊👊👊👊👊👊👊"
[ "$silent" == False ] && echo -e "💀${bold}$green Have a beer🍺💀 $end${normal}"
[ "$silent" == False ] && echo "👊👊👊👊👊👊👊👊👊"
[ "$silent" == False ] && echo -e "     ${bold}- twitter.com/Dheerajmadhukar : @me_dheeraj${normal}"
[ "$silent" == False ] && echo ""
}

Usage() {
        echo -e $green"GITAPP : Tool will display all data URLs from GitHub including XML, JSON, Java, Text, Kotlin, Ruby, Markdown, CSV, Python, PHP, GO, YAML, Elixir, C++, JavaScript, HTML & many more . . ."$end
        echo ""
        echo -e "$green Usage: ./gitapp [-d/--domain] domain.tld [-s/--silent]"$end
        echo -e "\t $green Options:"$end
        echo -e "\t $green -d/--domain: Target Domain: That will search for the target and find the data on GitHub"$end
        echo -e "\t $green -s / --silent: Only raw output"$end
        echo -e "$W \t Examples:"$end
        echo -e "$W \t \t bash ./gitapp -d domain.tld"$end
        echo -e "$W \t \t bash ./gitapp -d domain.tld -s"$end
        exit 1
}
main() {
[ "$silent" == False ] && curl -ks "https://grep.app/api/search?q=$domain&words=true" | jq -r '.facets.lang.buckets[] | .val,.count' | sed 'N;s/\n/ /' | tee /tmp/found-gitapp
[ "$silent" == False ] && echo "👊👊👊👊👊👊👊👊👊"
cat /tmp/found-gitapp | awk '{print $1}' | while read -r line;do z=1; while [ $z -gt 0 ];do out=$(curl -ks "https://grep.app/api/search?q=$domain&words=true&page=$z&f.lang=$line" | jq -r '.hits.hits[].id.raw' | sed -e 's/^g/https:\/\/github.com/g' -e 's|/|/blob/master/|5');if [ -z "$out" ];then z=0;else echo "$out"&&z=$[$z+1];fi;done&&echo "----------------";done
}
##########
domain=False
silent=False

list=(
        banner
        main
)
while [ -n "$1" ]; do
                    case "$1" in
                        -d | --domain)
                        domain=$2
                                shift
                                ;;
                        -s | --silent)
                        silent=True ;;
                        *) echo -e $red"[-]"$end "Unknown Option: $1"
                        Usage
                        ;;
          esac
shift
done
[[ $domain == "False" ]] && {
echo -e $red"[-]"$end "Argument: ./gitapp [-d/--domain] domain.tld [-s/--silent]"
Usage
}
(
banner
main
)
