import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import { Panel } from 'react-bootstrap';

import './styles.css';

const AccessableContainer = styled.div`
  margin-top: 1.4em;

  p,
  li {
    font-size: 14px;
  }

  > header {
    border-bottom: 1px solid #7f7f7f;
    padding-bottom: 0.5em;
    margin-bottom: 1.5em;

    > p {
      margin-bottom: 0;
      color: #000000;
    }
  }

  li {
    margin-bottom: 0.8em;
  }
`;

const CollapsibleHeaderCoursePanel = ({ description, isOpen }) => {
  const assessableItems = [
    'Text goes here that explains what this course is about and can include instructions.',
    'Text goes here that explains what this course is about and can include instructions.',
    'Text goes here that explains what this course is about and can include instructions.'
  ];

  // assessable items list
  const assessableList = assessableItems.map((item, i) => (
    <li key={i}>{`- ${item}`}</li>
  ));

  return (
    <div className="CollapsibleHeaderCoursePanel">
      <Panel collapsible expanded={isOpen}>
        <p>{description}</p>
        <AccessableContainer>
          <header>
            <p>Assessable Outcomes</p>
          </header>
          <ul>{assessableList}</ul>
        </AccessableContainer>
      </Panel>
    </div>
  );
};

CollapsibleHeaderCoursePanel.propTypes = {
  isOpen: PropTypes.bool.isRequired,
  description: PropTypes.string.isRequired
};

export default CollapsibleHeaderCoursePanel;
