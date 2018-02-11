import React from 'react';
import PropTypes from 'prop-types';

const ListRow = ({ style, children }) => {
    return (
        <li style={{ style }} className="List__row">
            {children}
        </li>
    );
};

ListRow.propTypes = {
    children: PropTypes.arrayOf(PropTypes.element),
    style: PropTypes.object
};

export default ListRow;
