import React from 'react';
import styled from 'styled-components';
// base
import Form from 'base_components/RootForm';
// sub components
import PanelCourseRules from './components/PanelCourseRules';
import PanelSetLesson from './components/PanelSetLesson';
import PanelFeatures from './components/PanelFeatures';
import PanelControlCourse from './components/PanelControlCourse';
import PanelControlUpdate from './components/PanelControlUpdate';

// container of modal body.
const FormModalBody = styled(Form)`
  padding: 25px 35px;
`;

const ModalBodyCourses = () => (
  <FormModalBody>
    <PanelCourseRules />
    <PanelSetLesson />
    <PanelFeatures />
    <PanelControlCourse />
    <PanelControlUpdate />
  </FormModalBody>
);

export default ModalBodyCourses;
