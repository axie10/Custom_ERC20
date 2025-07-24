// SPDX-License-Identifier: MIT

// Version
pragma solidity ^0.8.4;

// Interface
interface IERC20 {
    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // Functions
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(
        address account,
        uint256 amount
    ) external payable returns (bool);

    // Funcion para prestar tokens
    function allowance(
        address owner,
        address spender,
        uint256 amount
    ) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

abstract contract ERC20 is IERC20 {
    // for associate account with balance
    mapping(address => uint) private _balance;
    // for associate account with other account and how can spend this account
    // owner (pepe) -> spender (alberto) -> amount to spend (5 tokens)
    mapping(address => mapping(address => uint256)) private _allowance;

    // Variables
    uint256 private _totalSupply;
    string private name;
    string private symbol;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    // Basic functions
    function getName() public view virtual returns (string memory) {
        return name;
    }

    function getSymbol() public view virtual returns (string memory) {
        return symbol;
    }

    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(
        address account
    ) public view virtual override returns (uint256) {
        return _balance[account];
    }

    // Elemental functions
    function transfer(
        address account,
        uint256 amount
    ) public virtual override returns (bool) {
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(
        address owner,
        address spender,
        uint256 amount
    ) public view virtual override returns (uint256) {
        return _allowance[owner][spender];
    }

    function approve(
        address spender,
        uint256 amount
    ) public virtual override returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = msg.sender;
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function increaseAllowance(
        address spender,
        uint256 addedValue
    ) public virtual returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, _allowance[owner][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(
        address spender,
        uint256 subtractedValue
    ) public virtual returns (bool) {
        address owner = msg.sender;
        uint256 currentAllowance = _allowance[owner][spender];
        require(
            currentAllowance >= subtractedValue,
            "ERC20: decreased allowence below zero"
        );
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }
        return true;
    }

    //Internal functions
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        _beforeTokenTransfer(from, to, amount);
        uint256 fromBalance = _balance[from];
        require(
            fromBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        unchecked {
            _balance[from] = fromBalance - amount;
        }
        _balance[to] += amount;
        emit Transfer(from, to, amount);
        _afterTokenTransfer(from, to, amount);
    }

    function _mint(address account, uint amount) internal virtual {
        require(account != address(0), "ERC20: mint from the zero address");
        _beforeTokenTransfer(address(0), account, amount);
        _totalSupply += amount;
        _balance[account] += amount;
        // mean that create tokens (minting)
        emit Transfer(address(0), account, amount);
        _afterTokenTransfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");
        _beforeTokenTransfer(account, address(0), amount);
        uint256 accountBalance = _balance[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        _totalSupply -= amount;
        _balance[account] -= amount;
        emit Transfer(account, address(0), amount);
        _afterTokenTransfer(account, address(0), amount);
    }
}
