import React from 'react';

import LinkNavbarAdmin from '../LinkNavbarAdmin';

export default () => (
  <div>
    <li>
      {' '}
      <LinkNavbarAdmin activeClassName="active" to="/admin/group-manager">
        Group Manager
      </LinkNavbarAdmin>
    </li>
    <li>
      <LinkNavbarAdmin activeClassName="active" to="/admin/course-create">
        Course Creator
      </LinkNavbarAdmin>
    </li>
    <li>
      <LinkNavbarAdmin activeClassName="active" to="/admin/user-manager">
        User Manager
      </LinkNavbarAdmin>
    </li>
    <li>
      <LinkNavbarAdmin
        activeClassName="active"
        to="/admin/organisation-settings"
      >
        Organisation Settings
      </LinkNavbarAdmin>
    </li>
  </div>
);
