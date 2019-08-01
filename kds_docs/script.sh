git clone https://github.com/kubernetes/website.git
mkdir k8syamls
cd website\content\en
gfind -type f | grep yaml | xargs -i cp {} ../../../k8syamls/

## in new session
cd ../ckad/k8syamls

## is gsort -nr doesn't work?
grep --no-filename -o "[^:]*:" *.yaml | sed -e "s/ //g" | grep -v '\"' | grep -v "#" | gsort | uniq -c | gsort -nr | tac > ../keys.txt
grep --no-filename -o ":[^:]*" *.yaml | sed -e "s/ //g" | grep -v '\"' | grep -v "#" | gsort | uniq -c | gsort -nr | tac > ../values.txt