import React from 'react';
import PropTypes from 'prop-types';
import { isEmpty } from 'ramda';

import subscribingOnCourses from './hoc';
import NoCourses from './components/NoCourses';
import HasCourses from './components/HasCourses';

const Courses = ({ courses, match }) => {
  /* if there is courses render the HasCourses*/
  if (!isEmpty(courses)) {
    return <HasCourses match={match} courses={courses} />;
  }

  // else no courses
  return <NoCourses />;
};

Courses.propTypes = {
  courses: PropTypes.array
};

export default subscribingOnCourses(Courses);
