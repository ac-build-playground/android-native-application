for i in {1..1000}
do
  clear
  tput cup 5 5
  date
  tput cup 6 5
  echo "Hostname : $(hostname)"
  sleep 5s
done
