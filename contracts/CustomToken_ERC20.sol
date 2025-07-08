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
    uint256 private totalSupply;
    string private name;
    string private symbol;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function getName() public view virtual returns (string memory) {
        return name;
    }

    function getSymbol() public view virtual returns (string memory) {
        return symbol;
    }
}
