import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';

// for our media
import iconPlayButton from 'resources/images/play-button.svg';
import LinkButton from 'base_components/LinkButton';
// for our date
import DateTime from 'base_components/DateTime';
// for feedback
import UserAvatar from 'base_components/UserAvatar';
import iconUser from 'resources/images/user.png';
// for form
import Form, { CheckboxCircleSecondary } from 'base_components/RootForm';

// this is for meta span information component
const MetaInfo = styled.span`
  color: #9fa6ad;
  font-size: ${props => (props.default ? '14px' : '10px')};
`;

// this is for list item
const ListItemTutorial = styled(({ className, isReport }) => (
  <li className={`${className} ListItemTutorial`}>
    {!isReport ? (
      <div>
        <div className="ListItemTutorial__media">
          <img alt="Icon play button" src={iconPlayButton} />
          <div>
            <p>Vivamus suscipit tortor eget felis porttitor</p>
            <MetaInfo default>00:05:25</MetaInfo>
          </div>
        </div>
        <div className="ListItemTutorial__date">
          <DateTime accent bold center date="22nd Sep" time="5:25pm" />
          <MetaInfo>Last Activity</MetaInfo>
        </div>
        <div className="ListItemTutorial__feedback">
          <div>
            <UserAvatar small image={iconUser} />
            <UserAvatar small image={iconUser} />
          </div>
          <MetaInfo>Feedback / Discussion</MetaInfo>
        </div>
        <div className="ListItemTutorial__complete">
          <Form>
            <CheckboxCircleSecondary name="complete" />
          </Form>
          <MetaInfo>Mark Complete</MetaInfo>
        </div>
        <LinkButton text="View" url="/view" />
      </div>
    ) : (
      <div>
        <LinkButton
          style={{ backgroundColor: '#596065' }}
          text="Create Report"
          url="/report"
        />
      </div>
    )}
  </li>
))`
  > div {
    display: flex;
    align-items: center;
    justify-content: ${props =>
      props.isReport ? 'flex-end' : 'space-between'};
    padding: 1.7em 0 1.3em 0;
    border-bottom: 1px solid #dadada;

    @media screen and (max-width: 767px) {
      width: 750px;
    }

    .ListItemTutorial__media {
      display: flex;

      > div {
        margin-left: 1.3em;

        p {
          margin-bottom: 0;
          font-size: 16px;
          max-width: 150px;
        }
      }
    }

    .ListItemTutorial__feedback {
      text-align: center;

      img {
        margin-right: 0.4em;
        &:last-child {
          margin-right: 0;
        }
      }
    }

    .ListItemTutorial__complete {
      display: flex;
      flex-direction: column;
      align-items: center;

      form {
        margin-bottom: 0.3em;
      }
    }
  }

  &:last-child {
    > div {
      border-bottom: 0;
    }
  }

  @media screen and (min-width: 768px) {
    > div {
      padding: 2.3em 0;
    }
  }
`;

ListItemTutorial.propTypes = {
  isReport: PropTypes.bool
};

export default ListItemTutorial;
