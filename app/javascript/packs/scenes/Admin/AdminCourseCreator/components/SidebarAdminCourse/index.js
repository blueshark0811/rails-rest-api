import React from 'react';
import styled from 'styled-components';
import { withRouter } from 'react-router-dom';
// components
import ListLinkItem from './components/ListLinkItem';
//
import iconNewCourse from './new-course.svg';
import iconCourseLibrary from './course-library.svg';
import iconAddOns from './add-ons.svg';

const ListLink = styled.ul`
  min-height: 100vh;
  height: 100%;
  background-color: #000000;
  position: fixed;
`;

const SidebarAdminCourse = ({ match }) => (
  <ListLink>
    <ListLinkItem
      icon={iconNewCourse}
      text="New Course"
      url={`${match.path}/new-course`}
    />
    <ListLinkItem
      icon={iconCourseLibrary}
      text="Course Library"
      url={`${match.path}/courses`}
    />
    <ListLinkItem
      icon={iconAddOns}
      text="Add-ons"
      url={`${match.path}/add-ons`}
    />
  </ListLink>
);

export default withRouter(SidebarAdminCourse);
