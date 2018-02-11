import React from 'react';
import styled from 'styled-components';
//
import TitleSection from '../../../TitleSection';
import Dropdown from 'base_components/Dropdown';
import { MenuItem } from 'react-bootstrap';

const DropdownResult = Dropdown.extend`
  width: 160px;
`;

const HeaderReportCourse = styled(({ className }) => (
  <header className={className}>
    <TitleSection>Report</TitleSection>
    <div>
      <span>Final Mark Result</span>
      <DropdownResult title="Result" id="dropdown-size-medium">
        <MenuItem eventKey="1">Percentage</MenuItem>
        <MenuItem eventKey="2">Pass/Fail</MenuItem>
        <MenuItem eventKey="3">Competency</MenuItem>
        <MenuItem eventKey="4">Manual Entry</MenuItem>
      </DropdownResult>
    </div>
  </header>
))`
  padding-bottom: 0.8em;
  border-bottom: 1px solid #d8d8d8;

  > div > span:first-child {
    margin-right: 2em;
  }
`;

export default HeaderReportCourse;
