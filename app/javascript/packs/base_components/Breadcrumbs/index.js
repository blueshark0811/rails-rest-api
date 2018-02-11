import React from 'react';
import { NavLink } from 'react-router-dom';
import { Breadcrumbs as RootBreadcrumbs } from 'react-breadcrumbs-dynamic/dist/src';

import './styles.css';

const Breadcrumbs = () => {
  return (
    <div className="Breadcrumbs">
      <RootBreadcrumbs
        separator={<span className="Breadcrumbs__separator"> > </span>}
        item={NavLink}
        finalItem={'span'}
        finalProps={{
          style: { color: '#616161' }
        }}
      />
    </div>
  );
};

export default Breadcrumbs;
