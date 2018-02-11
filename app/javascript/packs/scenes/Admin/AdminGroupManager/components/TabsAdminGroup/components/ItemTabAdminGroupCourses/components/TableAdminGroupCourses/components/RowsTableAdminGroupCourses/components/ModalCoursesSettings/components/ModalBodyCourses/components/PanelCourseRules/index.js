import React from 'react';
import styled from 'styled-components';
// base
import Panel from 'base_components/Panel';
import ContainerFlexCourses from '../ContainerFlexCourses';
import { Switch } from 'base_components/RootForm';
import Dropdown from 'base_components/Dropdown';
import { MenuItem } from 'react-bootstrap';

const PanelCourseRules = styled(({ className }) => (
  <Panel isFullWidth className={className} title="Course Rules">
    <ContainerFlexCourses isSpaceBetween className="PanelCourseRules__switch">
      <span>
        Users must complete another course before this one is available.
      </span>
      <Switch name="course-rules" />
    </ContainerFlexCourses>
    <ContainerFlexCourses isSpaceBetween className="PanelCourseRules__dropdown">
      <span>Course to be completed before:</span>
      <Dropdown title="Select Course" id="dropdown-size-medium">
        <MenuItem eventKey="1">Action</MenuItem>
        <MenuItem eventKey="2">Another action</MenuItem>
        <MenuItem eventKey="3">Something else here</MenuItem>
        <MenuItem divider />
        <MenuItem eventKey="4">Separated link</MenuItem>
      </Dropdown>
    </ContainerFlexCourses>
  </Panel>
))`
  padding: 0;

  .caret {
    display: none;
  }

  .PanelCourseRules__switch {
    > span:first-child {
      width: 130px;
    }
  }

  .PanelCourseRules__dropdown {
    background-color: #fbfbfb;
    padding: 1.5em;
    margin-bottom: 0;

    > span:first-child {
      width: 130px;
    }
  }

  .dropdown {
    flex: 1;
    margin-left: 1.2em;

    button {
      width: 100%;
      text-align: left;
    }
  }

  @media screen and (min-width: 768px) {
    .caret {
      display: inline;
      float: right;
      top: 9px;
      position: relative;
    }
  }
`;

export default PanelCourseRules;
