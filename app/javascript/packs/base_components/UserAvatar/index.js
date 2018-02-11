import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

const UserAvatar = styled(({ image, className }) => (
  <img alt="user avatar" className={className} src={image} />
))`
  height: ${props => (props.small ? '25px' : '35px')};
  width: ${props => (props.small ? '25px' : '35px')};
  border-radius: 50%;
  object-position: top;
  object-fit: cover;
`;

UserAvatar.propTypes = {
  image: PropTypes.string.isRequired
};

export default UserAvatar;
