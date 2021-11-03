/*
 * This exercise has been updated to use Solidity version 0.8.5
 * See the latest Solidity updates at
 * https://solidity.readthedocs.io/en/latest/080-breaking-changes.html
 */
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16 <0.9.0;

contract SimpleBank {

    /* State variables
     */
    
    mapping (address => uint) private _balances;
    
    mapping (address => bool) private _enrolled;

    address public owner = msg.sender;
    
    /* Events - publicize actions to external listeners
     */
    
    event LogEnrolled(
        address indexed accountAddress
    );

    event LogDepositMade(
        address indexed accountAddress,
        uint amount
    );

    event LogWithdrawal(
        address indexed accountAddress,
        uint newBalance,
        uint withdrawAmount
    );

    /* Functions
     */

    fallback() external payable {
        revert();
    }

    receive() external payable {
        revert();
    }

    /// @notice Get balance
    /// @return The balance of the user
    function getBalance() public view returns (uint) {
        return _balances[msg.sender];
    }

    /// @notice Enroll a customer with the bank
    /// @return The users enrolled status
    function enroll() public returns (bool) {
        _enrolled[msg.sender] = true;
        emit LogEnrolled(msg.sender);
        return _enrolled[msg.sender];
    }

    /// @notice Check if a user is enrolled
    /// @param user The address of a user to check enrollment on
    /// @return Whether the user is enrolled
    function enrolled(address user) external view returns (bool) {
        return _enrolled[user];
    }

    /// @notice Deposit ether into bank
    /// @return The balance of the user after the deposit is made
    function deposit() public payable returns (uint) {
        require(_enrolled[msg.sender], 'User must be enrolled to deposit');

        uint oldBalance = _balances[msg.sender];
        uint newBalance = oldBalance + msg.value;

        _balances[msg.sender] = newBalance;

        emit LogDepositMade(msg.sender, msg.value);

        return newBalance;
    }

    /// @notice Withdraw ether from bank
    /// @dev This does not return any excess ether sent to it
    /// @param withdrawAmount amount you want to withdraw
    /// @return The balance remaining for the user
    function withdraw(uint withdrawAmount) public returns (uint) {
        require(withdrawAmount <= _balances[msg.sender], 'Insufficient balance');

        // Deduct from balance first to prevent reentrancy attack
        uint newBalance = _balances[msg.sender] - withdrawAmount;
        _balances[msg.sender] = newBalance;

        payable(msg.sender).transfer(withdrawAmount);

        emit LogWithdrawal(msg.sender, newBalance, withdrawAmount);

        return newBalance;
    }
}
