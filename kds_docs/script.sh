git clone https://github.com/kubernetes/website.git
mkdir k8syamls
find  website/content/en -type f | xargs -i cp {} k8syamls/
rm -rf website

## in new session
cd k8syamls
find . -type f ! -name "*.yaml" -exec rm -rf {} \;

## is gsort -nr doesn't work?
grep --no-filename -o "[^:]*:" *.yaml | sed -e "s/ //g" | sed -e "s/^-//g" | grep -v '\"' | grep -v "#" | sort | uniq -c | sort -nr | grep -v "1 " | grep -v "^1" > ../keys.txt
grep --no-filename -o ":[^:]*" *.yaml | sed -e "s/ //g" | sed -e "s/^-//g" | grep -v '\"' | grep -v "#" | sort | uniq -c | sort -nr | grep -v "1 " | grep -v ":$" | grep -v "^1" > ../values.txt
