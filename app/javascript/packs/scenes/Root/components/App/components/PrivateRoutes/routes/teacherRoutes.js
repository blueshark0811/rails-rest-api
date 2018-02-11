import React from 'react';
//
import ErrorBoundary from 'base_components/ErrorBoundary';
/* for code splitting - loadable */
import Loadable from 'react-loadable';
import Loader from 'base_components/Loader';

//------------------------- TEACHERS PANEL COMPONENT -------------------------------//
const AsyncGroupsActivity = Loadable({
  loader: () => import('scenes/TeacherGroupsActivity'),
  loading: Loader,
  timeout: 10000
});

const AsyncTeacherControls = Loadable({
  loader: () => import('scenes/TeacherControls'),
  loading: Loader,
  timeout: 10000
});

const AsyncTeacherFiles = Loadable({
  loader: () => import('scenes/TeacherFiles'),
  loading: Loader,
  timeout: 10000
});

const AsyncTeacherUserManager = Loadable({
  loader: () => import('scenes/TeacherUserManager'),
  loading: Loader,
  timeout: 10000
});

const teacherRoutes = [
  {
    id: 'teacher01',
    path: '/teachers/groups-activity',
    strict: true,
    exact: true,
    AsyncComponent: props => (
      <ErrorBoundary errMsg="Something went wrong in displaying the groups activity page.">
        <AsyncGroupsActivity {...props} />
      </ErrorBoundary>
    )
  },
  {
    id: 'teacher02',
    path: '/teachers/submissions-activity',
    strict: true,
    exact: true,
    AsyncComponent: props => (
      <ErrorBoundary errMsg="Something went wrong in displaying the teachers controls page.">
        <AsyncTeacherControls {...props} />
      </ErrorBoundary>
    )
  },
  {
    id: 'teacher03',
    path: '/teachers/files',
    strict: true,
    exact: true,
    AsyncComponent: props => (
      <ErrorBoundary errMsg="Something went wrong in displaying the teachers files page.">
        <AsyncTeacherFiles {...props} />
      </ErrorBoundary>
    )
  },
  {
    id: 'teacher04',
    path: '/teachers/user-manager',
    strict: true,
    exact: true,
    AsyncComponent: props => (
      <ErrorBoundary errMsg="Something went wrong in displaying the teachers user manager page.">
        <AsyncTeacherUserManager {...props} />
      </ErrorBoundary>
    )
  }
];

export default teacherRoutes;
