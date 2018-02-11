import React from 'react';
import PropTypes from 'prop-types';

// components
import ContainerFlex from 'base_components/ContainerFlex';
import SidebarAdminCourse from './components/SidebarAdminCourse';
import ContentAdminCourse from './components/ContentAdminCourse';

const AdminCourseCreator = ({ match }) => (
  <ContainerFlex>
    <SidebarAdminCourse />
    <ContentAdminCourse match={match} />
  </ContainerFlex>
);

AdminCourseCreator.propTypes = {
  match: PropTypes.object.isRequired
};

export default AdminCourseCreator;
