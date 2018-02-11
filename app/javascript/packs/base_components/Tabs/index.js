import React from 'react';
import PropTypes from 'prop-types';
import { Tabs as TabBootstrap } from 'react-bootstrap';

import './styles.css';

const Tabs = ({ style, children }) => {
    return (
        <TabBootstrap
            style={style}
            className="Tabs"
            defaultActiveKey={1}
            id="uncontrolled-tab-example"
        >
            {children}
        </TabBootstrap>
    );
};

Tabs.propTypes = {
    children: PropTypes.arrayOf(PropTypes.element).isRequired,
    style: PropTypes.object
};

export default Tabs;
