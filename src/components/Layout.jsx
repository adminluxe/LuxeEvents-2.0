import { Helmet } from "react-helmet";

export default function Layout({ children, title = "LuxeEvents", description, image }) {
  return (
    <>
      <Helmet>
        <title>{title}</title>
        {description && <meta name="description" content={description} />}
        {image && <meta property="og:image" content={image} />}
      </Helmet>
      {children}
    </>
  );
}
