import React from 'react';
import PropTypes from 'prop-types';
//
import Popover from 'base_components/Popover';
import UserAvatar from 'base_components/UserAvatar';
import IconDown from 'react-icons/lib/fa/angle-down';
import ButtonLogout from './components/ButtonLogout';
import './styles.css';

const Profile = ({ name, avatar, removeLoggedUser }) => {
  const PopoverProfileContent = (
    <ul>
      <ButtonLogout handlerClick={removeLoggedUser} />
    </ul>
  );

  return (
    <div className="Profile">
      <p>{name}</p>
      <UserAvatar image={avatar} />
      <Popover
        buttonIcon={<IconDown />}
        buttonStyle={{
          fontSize: '1.5rem'
        }}
        popoverContent={PopoverProfileContent}
      />
    </div>
  );
};

Profile.propTypes = {
  name: PropTypes.string.isRequired,
  avatar: PropTypes.string.isRequired,
  removeLoggedUser: PropTypes.func.isRequired
};

export default Profile;
