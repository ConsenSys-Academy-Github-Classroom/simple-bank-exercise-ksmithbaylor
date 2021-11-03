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
    
    mapping (address => uint) private balances;
    
    mapping (address => bool) private _enrolled;

    address public owner = msg.sender;
    
    /* Events - publicize actions to external listeners
     */
    
    // Add an argument for this event, an accountAddress
    event LogEnrolled(
        address accountAddress
    );

    // Add 2 arguments for this event, an accountAddress and an amount
    event LogDepositMade();

    // Create an event called LogWithdrawal
    // Hint: it should take 3 arguments: an accountAddress, withdrawAmount and a newBalance 
    event LogWithdrawal();

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
    function getBalance() public returns (uint) {
      // 1. A SPECIAL KEYWORD prevents function from editing state variables;
      //    allows function to run locally/off blockchain
      // 2. Get the balance of the sender of this transaction
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
    function deposit() public returns (uint) {
      // 1. Add the appropriate keyword so that this function can receive ether
    
      // 2. Users should be enrolled before they can make deposits

      // 3. Add the amount to the user's balance. Hint: the amount can be
      //    accessed from of the global variable `msg`

      // 4. Emit the appropriate event associated with this function

      // 5. return the balance of sndr of this transaction
    }

    /// @notice Withdraw ether from bank
    /// @dev This does not return any excess ether sent to it
    /// @param withdrawAmount amount you want to withdraw
    /// @return The balance remaining for the user
    function withdraw(uint withdrawAmount) public returns (uint) {
      // If the sender's balance is at least the amount they want to withdraw,
      // Subtract the amount from the sender's balance, and try to send that amount of ether
      // to the user attempting to withdraw. 
      // return the user's balance.

      // 1. Use a require expression to guard/ensure sender has enough funds

      // 2. Transfer Eth to the sender and decrement the withdrawal amount from
      //    sender's balance

      // 3. Emit the appropriate event for this message
    }
}
