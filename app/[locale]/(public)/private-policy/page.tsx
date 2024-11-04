import {notFound} from 'next/navigation';
import MdxArticle from '@/lib/components/mdx-article';
import matter from 'gray-matter'
import { locales } from '@/lib/i18n/locales';
const components: any = {
  img: ({src, alt}: { src: string, alt: string }) => {
      return <img src={src} alt={alt} className="object-cover"/>
  }
}

export function generateStaticParams() {
  return locales.map((locale) => ({ locale }));
}

export default async function Page({params}: {params: Promise<{locale: string}>}) {
  try {
    const {locale} = await params;
    // 直接导入 MDX 文件的原始内容
    let Content;
    try {
      Content = (await import(`!!raw-loader!./${locale}.mdx`)).default;
    } catch (error) {
      Content = (await import(`!!raw-loader!./en.mdx`)).default;
    }
    const {content } = matter(Content);
    
    return <>
        <article
          className="prose prose-sm md:prose-base lg:prose-lg  rounded-2xl max-w-3xl mx-auto py-10 px-4">
          <MdxArticle components={components} source={content} className="max-w-full"/>;
        </article>
    </>
  } catch (error) {
    notFound();
  }
}