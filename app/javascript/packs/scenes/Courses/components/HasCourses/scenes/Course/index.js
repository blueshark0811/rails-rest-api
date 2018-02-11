import React from 'react';
import PropTypes from 'prop-types';
import { BreadcrumbsItem } from 'react-breadcrumbs-dynamic/dist/src';
import { split, join, pipe } from 'ramda';
/* import { AnimatedRoute } from 'react-router-transition';*/
import { Route } from 'react-router-dom';

import HeaderCourseMeta from './components/HeaderCourseMeta';
import BodyCourseMeta from './components/BodyCourseMeta';
import './styles.css';

// code splitting
import Loadable from 'react-loadable';
const AsyncTutorial = Loadable({
  loader: () => import('./scenes/Tutorial'),
  loading: () => null, // before this component gets loaded, we will render first this Loader component.
  timeout: 10000
});

const Course = ({ match, courses }) => {
  // cachce variables
  const paramId = match.params.id;
  /* create the course title based on the url params*/
  const courseTitle = pipe(split('-'), join(' '))(paramId);
  // retrieve specific course based on the params id value
  const course = courses.filter(course => course.id === paramId)[0];
  return (
    <div className="Course">
      <BreadcrumbsItem to={match.url}>{courseTitle}</BreadcrumbsItem>
      <HeaderCourseMeta course={course} />
      <BodyCourseMeta course={course} />
      {/* subroutes - tutorials. */}
      <Route
        exact
        path={`${match.url}/tutorials/:id`}
        component={AsyncTutorial}
      />
    </div>
  );
};

Course.propTypes = {
  courses: PropTypes.array,
  match: PropTypes.object.isRequired
};

export default Course;
