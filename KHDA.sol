// Ref: https://ethereum.stackexchange.com/questions/26726/how-can-i-set-owners-in-constructor-when-create-contract
/* Madheswaran - madheswarant@gmail.com */
pragma solidity ^0.4.0;

contract KHDA {

    mapping (address => bool) private _owners;
    mapping (address => uint) private _balances;
    address private _masterAdmin;
    /*
    modifier isOwner() {
        require(_owners[msg.sender]);
        _;
    }
    */
   
    struct UserStruct {
    string userEmail;
    uint userAge;
    uint class;
    uint cgpa;
  }

  mapping(address => UserStruct) private userStructs;
  address[] private userIndex;

    modifier isOwner() {
        require(_masterAdmin == msg.sender || _owners[msg.sender]);
        _;
    }
      modifier isMasterAdmin() {
        require(_masterAdmin == msg.sender );
        _;
    }
    function KHDA() {
    _masterAdmin = msg.sender;
    }

    function addOwner(string _addr)
        isOwner {
        _owners[parseAddr(_addr)] = true;
    }

    function removeOwner(string _addr)
        isMasterAdmin {
        _owners[parseAddr(_addr)] = false;
    }

    // From https://github.com/oraclize/ethereum-api/blob/master/oraclizeAPI_pre0.4.sol#L157
    function parseAddr(string _a) internal returns (address){
        bytes memory tmp = bytes(_a);
        uint160 iaddr = 0;
        uint160 b1;
        uint160 b2;
        for (uint i=2; i<2+2*20; i+=2){
            iaddr *= 256;
            b1 = uint160(tmp[i]);
            b2 = uint160(tmp[i+1]);
            if ((b1 >= 97)&&(b1 <= 102)) b1 -= 87;
            else if ((b1 >= 48)&&(b1 <= 57)) b1 -= 48;
            if ((b2 >= 97)&&(b2 <= 102)) b2 -= 87;
            else if ((b2 >= 48)&&(b2 <= 57)) b2 -= 48;
            iaddr += (b1*16+b2);
        }
        return address(iaddr);
    }
   
   
  event LogNewUser   (address indexed userAddress, uint class, string userEmail, uint userAge,uint cgpa);
  event LogUpdateUser(address indexed userAddress, uint class, string userEmail, uint userAge,uint cgpa);
  event LogDeleteUser(address indexed userAddress, uint class);
   
   

function isUser(address userAddress)
    public
    constant
    returns(bool isIndeed)
  {
    if(userIndex.length == 0) return false;
    return (userIndex[userStructs[userAddress].class] == userAddress);
  }

  function insertUser(
    address userAddress,
    string userEmail,
    uint    userAge,
    uint cgpa)
    public
    returns(uint class)
  {
    
    if(isUser(userAddress)) throw;
    userStructs[userAddress].userEmail = userEmail;
    userStructs[userAddress].userAge   = userAge;
    userStructs[userAddress].class     = userIndex.push(userAddress)-1;
    userStructs[userAddress].cgpa   = cgpa;
    LogNewUser(
        userAddress,
        userStructs[userAddress].class,
        userEmail,
        userAge,cgpa);
    return userIndex.length-1;
  }

  function deleteUser(address userAddress)
    public
    returns(uint index)
  {
    
    if(!isUser(userAddress)) throw;
    uint rowToDelete = userStructs[userAddress].class;
    address keyToMove = userIndex[userIndex.length-1];
    userIndex[rowToDelete] = keyToMove;
    userStructs[keyToMove].class = rowToDelete;
    userIndex.length--;
    LogDeleteUser(
        userAddress,
        rowToDelete);
    LogUpdateUser(
        keyToMove,
        rowToDelete,
        userStructs[keyToMove].userEmail,
        userStructs[keyToMove].userAge,
        userStructs[keyToMove].cgpa);
    return rowToDelete;
  }
 
  function getUser(address userAddress)
    public
    constant
    returns(string userEmail, uint userAge, uint class,uint cgpa)
  {
    if(!isUser(userAddress)) throw;
    return(
      userStructs[userAddress].userEmail,
      userStructs[userAddress].userAge,
      userStructs[userAddress].class,
      userStructs[userAddress].cgpa);
  }
 
  function updateUserEmail(address userAddress, string userEmail)
    public
    returns(bool success)
  {
    if(!isUser(userAddress)) throw;
    userStructs[userAddress].userEmail = userEmail;
    LogUpdateUser(
      userAddress,
      userStructs[userAddress].class,
      userEmail,
      userStructs[userAddress].userAge,
      userStructs[userAddress].cgpa);
    return true;
  }
 
  function updateUserAge(address userAddress, uint userAge)
    public
    returns(bool success)
  {
    if(!isUser(userAddress)) throw;
    userStructs[userAddress].userAge = userAge;
    LogUpdateUser(
      userAddress,
      userStructs[userAddress].class,
      userStructs[userAddress].userEmail,
      userAge,
      userStructs[userAddress].cgpa);
    return true;
  }
  /*
  function updateUserCgpa(address userAddress, uint cgpa)
    public
    returns(bool success)
  {
    if(!isUser(userAddress)) throw;
    userStructs[userAddress].userAge = userAge;
    LogUpdateUser(
      userAddress,
      userStructs[userAddress].class,
      userStructs[userAddress].userEmail,
      userStructs[userAddress].userAge,
      cgpa);
    return true;
  }
  */

  function getUserCount()
    public
    constant
    returns(uint count)
  {
    return userIndex.length;
  }

  function getUserAtClass(uint class)
    public
    constant
    returns(address userAddress)
  {
    return userIndex[class];
  }


}

// Ref: https://ethereum.stackexchange.com/questions/26726/how-can-i-set-owners-in-constructor-when-create-contract
/* Madheswaran - madheswarant@gmail.com */
pragma solidity ^0.4.0;

contract KHDA {

    mapping (address => bool) private _owners;
    mapping (address => uint) private _balances;
    address private _masterAdmin;
    /*
    modifier isOwner() {
        require(_owners[msg.sender]);
        _;
    }
    */
   
    struct UserStruct {
    string userEmail;
    uint userAge;
    uint class;
    uint cgpa;
  }

  mapping(address => UserStruct) private userStructs;
  address[] private userIndex;

    modifier isOwner() {
        require(_masterAdmin == msg.sender || _owners[msg.sender]);
        _;
    }
      modifier isMasterAdmin() {
        require(_masterAdmin == msg.sender );
        _;
    }
    function KHDA() {
    _masterAdmin = msg.sender;
    }

    function addOwner(string _addr)
        isOwner {
        _owners[parseAddr(_addr)] = true;
    }

    function removeOwner(string _addr)
        isMasterAdmin {
        _owners[parseAddr(_addr)] = false;
    }

    // From https://github.com/oraclize/ethereum-api/blob/master/oraclizeAPI_pre0.4.sol#L157
    function parseAddr(string _a) internal returns (address){
        bytes memory tmp = bytes(_a);
        uint160 iaddr = 0;
        uint160 b1;
        uint160 b2;
        for (uint i=2; i<2+2*20; i+=2){
            iaddr *= 256;
            b1 = uint160(tmp[i]);
            b2 = uint160(tmp[i+1]);
            if ((b1 >= 97)&&(b1 <= 102)) b1 -= 87;
            else if ((b1 >= 48)&&(b1 <= 57)) b1 -= 48;
            if ((b2 >= 97)&&(b2 <= 102)) b2 -= 87;
            else if ((b2 >= 48)&&(b2 <= 57)) b2 -= 48;
            iaddr += (b1*16+b2);
        }
        return address(iaddr);
    }
   
   
  event LogNewUser   (address indexed userAddress, uint class, string userEmail, uint userAge,uint cgpa);
  event LogUpdateUser(address indexed userAddress, uint class, string userEmail, uint userAge,uint cgpa);
  event LogDeleteUser(address indexed userAddress, uint class);
   
   

function isUser(address userAddress)
    public
    constant
    returns(bool isIndeed)
  {
    if(userIndex.length == 0) return false;
    return (userIndex[userStructs[userAddress].class] == userAddress);
  }

  function insertUser(
    address userAddress,
    string userEmail,
    uint    userAge,
    uint cgpa)
    public
    returns(uint class)
  {
    
    if(isUser(userAddress)) throw;
    userStructs[userAddress].userEmail = userEmail;
    userStructs[userAddress].userAge   = userAge;
    userStructs[userAddress].class     = userIndex.push(userAddress)-1;
    userStructs[userAddress].cgpa   = cgpa;
    LogNewUser(
        userAddress,
        userStructs[userAddress].class,
        userEmail,
        userAge,cgpa);
    return userIndex.length-1;
  }

  function deleteUser(address userAddress)
    public
    returns(uint index)
  {
    
    if(!isUser(userAddress)) throw;
    uint rowToDelete = userStructs[userAddress].class;
    address keyToMove = userIndex[userIndex.length-1];
    userIndex[rowToDelete] = keyToMove;
    userStructs[keyToMove].class = rowToDelete;
    userIndex.length--;
    LogDeleteUser(
        userAddress,
        rowToDelete);
    LogUpdateUser(
        keyToMove,
        rowToDelete,
        userStructs[keyToMove].userEmail,
        userStructs[keyToMove].userAge,
        userStructs[keyToMove].cgpa);
    return rowToDelete;
  }
 
  function getUser(address userAddress)
    public
    constant
    returns(string userEmail, uint userAge, uint class,uint cgpa)
  {
    if(!isUser(userAddress)) throw;
    return(
      userStructs[userAddress].userEmail,
      userStructs[userAddress].userAge,
      userStructs[userAddress].class,
      userStructs[userAddress].cgpa);
  }
 
  function updateUserEmail(address userAddress, string userEmail)
    public
    returns(bool success)
  {
    if(!isUser(userAddress)) throw;
    userStructs[userAddress].userEmail = userEmail;
    LogUpdateUser(
      userAddress,
      userStructs[userAddress].class,
      userEmail,
      userStructs[userAddress].userAge,
      userStructs[userAddress].cgpa);
    return true;
  }
 
  function updateUserAge(address userAddress, uint userAge)
    public
    returns(bool success)
  {
    if(!isUser(userAddress)) throw;
    userStructs[userAddress].userAge = userAge;
    LogUpdateUser(
      userAddress,
      userStructs[userAddress].class,
      userStructs[userAddress].userEmail,
      userAge,
      userStructs[userAddress].cgpa);
    return true;
  }
  /*
  function updateUserCgpa(address userAddress, uint cgpa)
    public
    returns(bool success)
  {
    if(!isUser(userAddress)) throw;
    userStructs[userAddress].userAge = userAge;
    LogUpdateUser(
      userAddress,
      userStructs[userAddress].class,
      userStructs[userAddress].userEmail,
      userStructs[userAddress].userAge,
      cgpa);
    return true;
  }
  */

  function getUserCount()
    public
    constant
    returns(uint count)
  {
    return userIndex.length;
  }

  function getUserAtClass(uint class)
    public
    constant
    returns(address userAddress)
  {
    return userIndex[class];
  }


}

