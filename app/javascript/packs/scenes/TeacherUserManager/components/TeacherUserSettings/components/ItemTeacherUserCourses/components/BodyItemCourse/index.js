import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

import IconRight from 'react-icons/lib/fa/angle-right';
import IconDown from 'react-icons/lib/fa/angle-down';
import Form, { Switch } from 'base_components/RootForm';

import './styles.css';

// we will use this for button of a panel
const ButtonPanel = styled.p`
  font-weight: 800;
  font-size: 12px;
  text-transform: uppercase;
  cursor: pointer;
  transition: all 300ms ease-in;
  margin-bottom: 0;
  display: inline-block;

  &:hover {
    color: #338ffc;
  }
`;

// for span icon.
const SpanIcon = styled.span`
  font-size: 18px;
  font-weight: 800;
  margin-left: 0.3em;
`;

const BodyItemCourse = styled(({ className, isOpenPanel, onToggle }) => (
  <div className={className}>
    <div>
      <span>Enable / Disable</span>
      <Form>
        <Switch name="course-switch" />
      </Form>
    </div>
    <ButtonPanel onClick={() => onToggle()}>
      View Lessons
      {isOpenPanel ? (
        <SpanIcon>
          <IconDown />
        </SpanIcon>
      ) : (
        <SpanIcon>
          <IconRight />
        </SpanIcon>
      )}
    </ButtonPanel>
  </div>
))`
  margin-top: 2em;

  > div:first-child {
    display: flex;
    align-items: center;
    color: #9fa6ad;
    margin-bottom: 1.3em;
    font-size: 12px;

    > span {
      margin-right: 1em;
    }

    form {
      height: 22px;
    }
  }

  @media screen and (min-width: 768px) {
    display: flex;
    justify-content: space-between;
    margin-top: 3em;
  }
`;

BodyItemCourse.propTypes = {
  onToggle: PropTypes.func.isRequired,
  isOpenPanel: PropTypes.bool.isRequired
};

export default BodyItemCourse;
