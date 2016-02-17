encrypt(){
      openssl des3 -in important.txt -out ~/important.encryted
}

decrypt(){
     openssl des3 -d -in ~/important.encryted
}
