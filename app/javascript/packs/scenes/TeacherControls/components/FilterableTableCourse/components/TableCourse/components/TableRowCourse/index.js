import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import { map } from 'ramda';

import { TableRow } from 'base_components/Tables';
import RootForm, { CheckboxCircle } from 'base_components/RootForm';
import UserAvatar from 'base_components/UserAvatar';
import FlaggedIcon from '../../../FlaggedIcon';

// for table row data.
const TableRowCourseTd = styled.td`
  text-align: ${props => (props.middle ? 'center' : 'left')};
  margin-top: 0.7em;
`;

// for table row course.
const DateSpan = styled.span`
  color: #7e7e7e;
  display: block;
`;

// extending the user avatar component.
const ExtendUserAvatar = UserAvatar.extend`
  margin-right: 0.5em;
  &:last-child {
    margin-right: 0;
  }
`;

// component for the table row course.
const TableRowCourse = ({ course }) => {
  const {
    feedbacks,
    title,
    person,
    date,
    lesson,
    lastAction,
    isFlagged
  } = course;
  let feedbacksItem;
  if (feedbacks.length) {
    feedbacksItem = map(
      item => <ExtendUserAvatar key={item.id} small image={item.avatarURL} />,
      feedbacks
    );
  }
  return (
    <TableRow>
      <TableRowCourseTd>
        <DateSpan>{date.day}</DateSpan>
        <DateSpan>{date.time}</DateSpan>
      </TableRowCourseTd>
      <TableRowCourseTd>{title}</TableRowCourseTd>
      <TableRowCourseTd>{lesson}</TableRowCourseTd>
      <TableRowCourseTd>
        <ExtendUserAvatar small image={course.person.avatarURL} />
        <span>{person.name}</span>
      </TableRowCourseTd>
      <TableRowCourseTd>{lastAction}</TableRowCourseTd>
      <TableRowCourseTd>{feedbacksItem}</TableRowCourseTd>
      <TableRowCourseTd middle>
        <FlaggedIcon big isFlagged={isFlagged} />
      </TableRowCourseTd>
      <TableRowCourseTd middle style={{ textAlign: 'center' }}>
        <RootForm>
          <CheckboxCircle name="read" />
        </RootForm>
      </TableRowCourseTd>
    </TableRow>
  );
};

TableRowCourse.propTypes = {
  course: PropTypes.object.isRequired
};

export default TableRowCourse;
