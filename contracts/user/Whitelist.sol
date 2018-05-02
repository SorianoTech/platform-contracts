/*
    Smart contract of user status.

    Copyright (C) 2018 EthicHub

    This file is part of platform contracts.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
pragma solidity ^0.4.23;

import '../ownership/Ownable.sol';
import '../EthicHubBase.sol';
import '../math/SafeMath.sol';

/* @title User
@dev This is an extension to add user 
*/
contract User is Ownable, EthicHubBase {


    event UserStatusChanged(address target, bool isRegistered);

    constructor(address _storageAddress, address[] _registered_accounts)
        EthicHubBase(_storageAddress)
        public
    {
        // Version
        version = 1;
        changeUsersStatus(_registered_accounts, true);
    }

    /**
     * @dev Changes registration status of an address for participation.
     * @param target Address that will be registered/deregistered.
     * @param isRegistered New registration status of address.
     */
    function changeUserStatus(address target, bool isRegistered)
        public
        onlyOwner
    {
        ethicHubStorage.setBool(keccak256("lending.user", target), isRegistered);
        emit UserStatusChanged(target, isRegistered);
    }

    /**
     * @dev Changes registration statuses of addresses for participation.
     * @param targets Addresses that will be registered/deregistered.
     * @param isRegistered New registration status of addresses.
     */
    function changeUsersStatus(address[] targets, bool isRegistered)
        public
        onlyOwner
    {
        for (uint i = 0; i < targets.length; i++) {
            changeUserStatus(targets[i], isRegistered);
        }
    }


    /**
     * @dev View registration status of an address for participation.
     * @return isRegistered boolean registration status of address.
     */
    function viewRegistrationStatus(address target)
        view public
        returns(bool isRegistered)
    {
        isRegistered = ethicHubStorage.getBool(keccak256("lending.user", target));
    }
}

