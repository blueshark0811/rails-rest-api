import React from 'react';
import PropTypes from 'prop-types';
import classNames from 'classnames';

import LogoContainer from 'base_components/LogoContainer';
import Menu from './components/Menu';
import DropdownGroups from './components/DropdownGroups';
import Link from 'base_components/Link';
import './styles.css';

const Sidebar = ({ isOpen, onCloseSidebar }) => {
  // construct our mainPages links that we will integrate on our sidebar
  const mainPagesLink = (
    <Menu>
      <li className="Sidebar__item">
        <Link text="Dashboard" url="/" />
      </li>
      <li className="Sidebar__item">
        <Link isStrict={true} text="Courses" url="/courses" />
      </li>
      <li className="Sidebar__item">
        <Link text="Files" url="/files" />
      </li>
      <li className="Sidebar__item">
        <Link text="People" url="/people" />
      </li>
    </Menu>
  );

  // this is for teacher panel links
  const teacherPanelLinks = (
    <Menu>
      <li className="Sidebar__item">
        <Link text="Groups Activiy" url="/teachers/groups-activity" />
      </li>
      <li className="Sidebar__item">
        <Link
          text="Submissions Activity"
          url="/teachers/submissions-activity"
        />
      </li>
      <li className="Sidebar__item">
        <Link text="Files" url="/teachers/files" />
      </li>
      <li className="Sidebar__item">
        <Link text="User Manager" url="/teachers/user-manager" />
      </li>
    </Menu>
  );

  // this is for public other link
  const otherLinks = (
    <Menu>
      <li className="Sidebar__item">
        <Link text="Groups" url="/groups" />
      </li>
      <li className="Sidebar__item">
        <Link text="Settings" url="/settings" />
      </li>
    </Menu>
  );

  // when the isOpen props is true, add other classname on sidebar
  const sidebarClassnames = classNames('Sidebar', { isOpen });

  return (
    <div onClick={onCloseSidebar} className={sidebarClassnames}>
      <div className="Sidebar__inner">
        <LogoContainer />
        <div className="Sidebar__body">
          <div className="Sidebar__body__mainPages">
            <DropdownGroups />
            {
              // we will put here the links that we created
              mainPagesLink
            }
          </div>
          <div className="Sidebar__body__otherPages">{teacherPanelLinks}</div>
          <div className="Sidebar__body__otherPages">{otherLinks}</div>
        </div>
      </div>
    </div>
  );
};

Sidebar.propTypes = {
  onCloseSidebar: PropTypes.func.isRequired,
  isOpen: PropTypes.bool.isRequired
};

export default Sidebar;
