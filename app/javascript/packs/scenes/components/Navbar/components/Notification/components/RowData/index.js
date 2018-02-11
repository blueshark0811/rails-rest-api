import React from 'react';
import PropTypes from 'prop-types';

import './styles.css';

const RowData = ({ userName, date, message, avatar }) => {
  return (
    <li className="RowData">
      {avatar && (
        <div className="RowData__avatar">
          <img style={rowDataStyle.rowDataImg} src={avatar} alt={userName} />
        </div>
      )}
      <div className="RowData__info">
        <div className="RowData__info__header">
          {userName && <p>{userName}</p>}
          <span>{date}</span>
        </div>
        <div className="RowData__info__body">
          <p>{message}</p>
        </div>
      </div>
    </li>
  );
};

RowData.propTypes = {
  userName: PropTypes.string,
  date: PropTypes.string.isRequired,
  message: PropTypes.string.isRequired,
  avatar: PropTypes.string
};

const rowDataStyle = {
  rowDataImg: {
    height: 30,
    width: 30,
    objectFit: 'cover',
    objectPosition: 'top'
  }
};

export default RowData;
