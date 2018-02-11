import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import { Panel } from 'react-bootstrap';
// sub components.
import ListTutorialCourse from './components/ListTutorialCourse';

// overriding the styles for the root panel component.
const ContainerCollapsiblePanel = styled(Panel)`
  .panel-body {
    padding-bottom: 0.8em;
    border-bottom: 1px solid #dadada;
  }

  @media screen and (min-width: 768px) {
    .panel-body {
      padding: 0 2.4em;
    }
  }
`;

const CollapsiblePanelItemCourse = ({ isOpenPanel }) => (
  <ContainerCollapsiblePanel collapsible expanded={isOpenPanel}>
    <ListTutorialCourse />
  </ContainerCollapsiblePanel>
);

CollapsiblePanelItemCourse.propTypes = {
  isOpenPanel: PropTypes.bool.isRequired
};

export default CollapsiblePanelItemCourse;
