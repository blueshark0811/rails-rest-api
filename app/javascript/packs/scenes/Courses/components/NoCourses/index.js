import React from 'react';
import { Link } from 'react-router-dom';

import './styles.css';
import infoIcon from './info.svg';

const NoCourses = () => {
  return (
    <section className="NoCourses">
      <h3>You do not have any courses.</h3>
      <div className="NoCourses__info">
        <img src={infoIcon} alt="information" />
        <Link to="/">Learn more about courses.</Link>
      </div>
    </section>
  );
};

export default NoCourses;
