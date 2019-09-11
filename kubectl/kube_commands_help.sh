isSubCommandExist()
{
  result=$(kubectl $1 --help | grep "Available Commands" | wc -l)
  if ((result == 1)); then
    echo "It has sub command".$result
  fi
  return $result
}

listSubCommands()
{
  sub_commands=$(kubectl create --help  | grep "^  [a-z]"  | grep -v "kubectl" | awk '{print $1}')
  return sub_commands
}

printSubSubCommands()
{
    svc=$(kubectl $1 $2 --help  | grep "^  [a-z]"  | grep -v "kubectl" | awk '{print $1}')
    for sc in $svc;do 
    echo "____________________________";
    echo kubectl $1 $2 $sc --help
    echo "----------------------------";
    kubectl $1 $2 $sc --help
    done
}


main() 
{
export kc=$(kubectl | grep "^  " | grep -v "kubectl" | awk '{print $1}')
for c in $kc;
do
  result=$(kubectl $c --help | grep "Available Commands" | wc -l)
  if ((result == 1)); then
    sub_commands=$(kubectl $c --help  | grep "^  [a-z]"  | grep -v "kubectl" | awk '{print $1}')
    for sc in $sub_commands;do
      echo "____________________________";
      echo kubectl $c $sc --help
      echo "----------------------------";
      kubectl $c $sc --help
    done
  else
    echo "______________";
    echo kubectl $c --help
    echo "--------------";
    kubectl $c --help
  fi
done
printSubSubCommands create service
printSubSubCommands create secret
}

main

