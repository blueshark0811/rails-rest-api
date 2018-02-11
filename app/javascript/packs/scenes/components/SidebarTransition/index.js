import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { withRouter } from 'react-router-dom';

import Navbar from '../Navbar';
import Sidebar from '../Sidebar';

class SidebarTransition extends Component {
  static propTypes = {
    location: PropTypes.object.isRequired
  };

  constructor() {
    super();
    this.state = {
      isSidebarOpen: false
    };
  }

  // opening the sidebar
  openSidebar = () =>
    this.setState({
      isSidebarOpen: true
    });

  // closing the sidebar
  closeSidebar = e => {
    // we only want to update the state when the sidebar wrapper is clicked
    // if the child of the sidebar is clicked, we dont want to close the sidebar
    if (e.target.className === 'Sidebar isOpen') {
      this.setState({
        isSidebarOpen: false
      });
    }
  };

  componentWillReceiveProps(nextProps) {
    // we need to check here if the key of location is changed.
    // if changed close the sidebar.
    if (nextProps.location.key !== this.props.location.key) {
      this.setState({
        isSidebarOpen: false
      });
    }
  }

  render() {
    return (
      <div>
        <Navbar onOpenSidebar={this.openSidebar} />
        <Sidebar
          isOpen={this.state.isSidebarOpen}
          onCloseSidebar={this.closeSidebar}
        />
      </div>
    );
  }
}

export default withRouter(SidebarTransition);
