import React from 'react';
import { Link } from 'react-router-dom';

import './styles.css';
import Logo from 'resources/images/logo.svg';
import { $textBoldColor } from 'shared/color.js';

const LogoContainer = () => {
  return (
    <Link className="LogoContainer" to="/">
      <img alt="Logo" src={Logo} />
      <h1 style={{ color: $textBoldColor }}>EquipEngine</h1>
    </Link>
  );
};

export default LogoContainer;
