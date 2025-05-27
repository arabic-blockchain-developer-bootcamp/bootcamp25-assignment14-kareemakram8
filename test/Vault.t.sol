// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;
    address user = makeAddr("user");

    function setUp() public {
        vault = new Vault();
        vm.deal(user, 10 ether);  // Fund user with 10 ETH for testing
    }

    function testDeposit() public {
        vm.prank(user);
        vault.deposit{value: 1 ether}();

        assertEq(vault.balances(user), 1 ether);
    }

    function testWithdraw() public {
        vm.prank(user);
        vault.deposit{value: 2 ether}();

        vm.prank(user);
        vault.withdraw(1 ether);

        assertEq(vault.balances(user), 1 ether);
    }

    function test_RevertWithdrawMoreThanBalance() public {
        vm.prank(user);
        vault.deposit{value: 1 ether}();

        vm.prank(user);
        vm.expectRevert("Insufficient balance");
        vault.withdraw(2 ether);
    }

   function testGetBalance() public {
    vm.prank(user);
    vault.deposit{value: 0.5 ether}();

    vm.prank(user);
    uint256 bal = vault.getBalance();

    assertEq(bal, 0.5 ether);
}

}

