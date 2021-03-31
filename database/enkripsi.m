clear all
secretKey = "kuncirahasiafinger";
algorithm = "MD5";
aes = AES(secretKey, algorithm);

originalString = "edward404";
encryptedString = aes.encrypt(originalString);
decryptedString = aes.decrypt(encryptedString) ; 

% edward = edward123
% nickey = nickey123
% jonson = jonson123
% charly = charly123
% dalton = dalton123

%  if i==1
%         class='Nickey';
%     elseif i==2
%         class='Jonson';
%     elseif i==3
%         class='Charly';
%     elseif i==4
%         class='Dalton';
%     elseif i==5
%         class='Edward';
%     end