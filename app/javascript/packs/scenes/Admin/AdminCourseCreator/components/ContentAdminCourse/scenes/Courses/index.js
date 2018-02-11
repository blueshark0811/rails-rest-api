import React from 'react';
import styled from 'styled-components';
import { Route, Switch } from 'react-router-dom';
// for our breadcrumbs
import { BreadcrumbsItem } from 'react-breadcrumbs-dynamic';
// component
import ErrorBoundary from 'base_components/ErrorBoundary';
import Breadcrumbs from 'base_components/Breadcrumbs';
import FilterableTableCourses from './components/FilterableTableCourses';
// Scenes
import Loader from 'base_components/Loader';
import Loadable from 'react-loadable';
const AsyncCourse = Loadable({
  loader: () => import('./scenes/Course'),
  loading: Loader, // before this component gets loaded, we will render first this Loader component.
  timeout: 10000
});

const ContainerCourses = styled.div`
  @media screen and (min-width: 768px) {
    margin-top: 53px;
  }
`;

const Courses = ({ match }) => {
  return (
    <ContainerCourses>
      <Breadcrumbs />
      <BreadcrumbsItem to={match.url}>Courses</BreadcrumbsItem>
      <Switch>
        <Route
          exact
          path={`${match.url}`}
          render={props => (
            <ErrorBoundary errMsg="Something went wrong in displaying the course page.">
              <FilterableTableCourses {...props} />
            </ErrorBoundary>
          )}
        />
        <Route
          path={`${match.url}/:id`}
          render={props => (
            <ErrorBoundary errMsg="Something went wrong in displaying the course page.">
              <AsyncCourse {...props} />
            </ErrorBoundary>
          )}
        />
      </Switch>
    </ContainerCourses>
  );
};

export default Courses;
