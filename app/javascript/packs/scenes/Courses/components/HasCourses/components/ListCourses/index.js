import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

import Box from 'base_components/Box';
import TutorialsCompleted from './components/TutorialsCompleted';
import LinkButton from 'base_components/LinkButton';
import List, { ListRow, ListRowLeft, ListRowRight } from 'base_components/List';

import './styles.css';

const ReportButton = styled(LinkButton)`
  @media screen and (min-width: 768px) {
    margin-right: 1.1em;
  }
`;

const ViewButton = styled(LinkButton)`
  width: 100%;
`;

const ListCourses = ({ courses }) => {
  const listCourses = courses.map((course, i) => {
    return (
      <ListRow key={course.courseId}>
        <ListRowLeft>
          <p>{course.title}</p>
          <p>{course.subtitle}</p>
        </ListRowLeft>
        <ListRowRight className="ListCourses__right">
          <ReportButton
            style={{
              marginTop: '3.4em'
            }}
            secondary
            text="Reports"
            url={'/courses/' + course.id}
          />
          <div>
            <TutorialsCompleted />
            <ViewButton text="View" url={'/courses/' + course.id} />
          </div>
        </ListRowRight>
      </ListRow>
    );
  });
  return (
    <Box>
      <List className="ListCourses">{listCourses}</List>
    </Box>
  );
};

ListCourses.propTypes = {
  courses: PropTypes.array
};

export default ListCourses;
