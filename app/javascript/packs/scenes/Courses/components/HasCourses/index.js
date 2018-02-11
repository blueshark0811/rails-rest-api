import React from 'react';
import PropTypes from 'prop-types';
import { Switch, Route } from 'react-router-dom';

import ErrorBoundary from 'base_components/ErrorBoundary';
import ListCourses from './components/ListCourses';
// for our breadcrumbs
import Breadcrumbs from 'base_components/Breadcrumbs';
import { BreadcrumbsItem } from 'react-breadcrumbs-dynamic/dist/src';
/* for our code splitting, render this components asynchronous*/
import Loader from 'base_components/Loader';
import Loadable from 'react-loadable';
const AsyncCourse = Loadable({
  loader: () => import('./scenes/Course'),
  loading: Loader, // before this component gets loaded, we will render first this Loader component.
  timeout: 10000
});

const HasCourses = ({ courses, match }) => {
  return (
    <div>
      {/* for our breadcrumbs item - get the current url and add it to its url */}
      <Breadcrumbs />
      <BreadcrumbsItem to={match.url}>Courses</BreadcrumbsItem>
      {/* only want to render this list courses on the courses route */}
      <Switch>
        <Route
          exact
          path={`${match.url}`}
          render={props => <ListCourses {...props} courses={courses} />}
        />
        <Route
          path={`${match.url}/:id`}
          render={props => {
            return (
              <ErrorBoundary errMsg="Something went wrong in displaying the course page.">
                <AsyncCourse {...props} courses={courses} />
              </ErrorBoundary>
            );
          }}
        />
      </Switch>
    </div>
  );
};

HasCourses.propTypes = {
  courses: PropTypes.array,
  match: PropTypes.object.isRequired
};

export default HasCourses;
